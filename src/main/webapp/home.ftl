<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
</head>
<body>
<div class="jumbotron">
    <h3>App2drive demo</h3>
</div>

<div class="container">

    <div id="customer-form">
        <div class="form-group">
            <label>Customer's name:</label>
            <input type="text" class="form-control" id="customerName" placeholder="Enter name">
            <small id="customer-help" class="form-text text-muted">Atelier graphique</small>
        </div>
        <button type="submit" id="customer-button" class="btn btn-primary">Get amount</button>
    </div>

    <br>

    <div id="resultContainer" class="container">
        <div class="row">
            <div class="col-6">
                <span>Amount of money, that customer spend: </span>
            </div>
            <div class="col-6">
                <input readonly class="form-control" id="result">
            </div>
        </div>
    </div>


    <br>
    <br>
    <br>
    <br>
    <br>

    <div class="container">
        <h4>SQL queries</h4>

        <div class="container">
            <h4>Query 1</h4>
            <div class="card">
                <div class="card-body">
                    SELECT customers.customername,SUM(PAYMENTS.amount) <br/>
                    FROM CUSTOMERS LEFT JOIN PAYMENTS ON CUSTOMERS.customernumber = PAYMENTS.customernumber <br/>
                    GROUP BY CUSTOMERS.customername; <br/>
                </div>
            </div>
        </div>

        <div class="container">
            <h4>Query 2</h4>
            <div class="card">
                <div class="card-body">
                    <span>
                        SELECT OFFICES.officecode,COUNT(*) <br/>
                        FROM ORDERS <br/>
                        LEFT JOIN CUSTOMERS ON ORDERS.customernumber = CUSTOMERS.customernumber <br/>
                        LEFT JOIN employees ON CUSTOMERS.salesrepemployeenumber = employees.employeenumber <br/>
                        LEFT JOIN OFFICES ON  employees.officecode = OFFICES.officecode <br/>
                        GROUP BY OFFICES.officecode <br/>
                        ORDER BY 2 DESC <br/>
                        LIMIT 1; <br/>
                    </span>
                </div>
            </div>
        </div>

        <div class="container">
            <h4>Query 3</h4>
            <div class="card">
                <div class="card-body">
                    <span>
                        SELECT PRODUCTS.productname,COUNT(*) <br/>
                        FROM PRODUCTS <br/>
                        LEFT JOIN ORDERDETAILS ON ORDERDETAILS.productcode = PRODUCTS.productcode <br/>
                        GROUP BY PRODUCTS.productcode <br/>
                        ORDER BY 2 DESC <br/>
                        LIMIT 1; <br/>
                    </span>
                </div>
            </div>
        </div>

        <div class="container">
            <h4>Query 4</h4>
            <div class="card">
                <div class="card-body">
                    <span>
                    SELECT a.officecode,(a.sum - b.sum) as pureincome <br/>
                    FROM((SELECT OFFICES.officecode,SUM(PRODUCTS.BUYPRICE * ORDERDETAILS.quantityordered) <br/>
                          FROM OFFICES <br/>
                          LEFT JOIN employees ON  employees.officecode = OFFICES.officecode <br/>
                          LEFT JOIN CUSTOMERS ON CUSTOMERS.salesrepemployeenumber = employees.employeenumber <br/>
                          LEFT JOIN ORDERS ON CUSTOMERS.customernumber = ORDERS.customernumber <br/>
                          LEFT JOIN ORDERDETAILS ON ORDERDETAILS.ordernumber = ORDERS.ordernumber <br/>
                          LEFT JOIN PRODUCTS ON ORDERDETAILS.productcode = PRODUCTS.productcode <br/>
                          WHERE ORDERS.shippeddate >='2004-03-02' AND ORDERS.shippeddate <= '2005-06-07' <br/>
                          GROUP BY OFFICES.officecode) b <br/>
                    CROSS JOIN <br/>
                    (SELECT OFFICES.officecode,SUM(ORDERDETAILS.priceeach * ORDERDETAILS.quantityordered) <br/>
                     FROM OFFICES <br/>
                     LEFT JOIN employees ON  employees.officecode = OFFICES.officecode <br/>
                     LEFT JOIN CUSTOMERS ON CUSTOMERS.salesrepemployeenumber = employees.employeenumber <br/>
                     LEFT JOIN ORDERS ON CUSTOMERS.customernumber = ORDERS.customernumber <br/>
                     LEFT JOIN ORDERDETAILS ON ORDERDETAILS.ordernumber = ORDERS.ordernumber <br/>
                     WHERE ORDERS.shippeddate >='2004-03-02' AND ORDERS.shippeddate <= '2005-06-07' <br/>
                     GROUP BY OFFICES.officecode) a <br/>
                    ) <br/>
                    WHERE a.officecode = b.officecode <br/>
                    ORDER BY 2 DESC <br/>
                    </span>
                </div>
            </div>
        </div>

    </div>
</div>

<script>
    $(document).ready(function () {
        $("#customer-button").click(function () {
            $("#customer-button").prop("disabled", true);
            $.ajax({
                type: "GET",
                contentType: "application/json",
                url: "/api/customers/amount?customerName=" + $("#customerName").val(),
                cache: false,
                timeout: 10000,
                success: function (data) {
                    $("#result").val(data);
                    $("#customer-button").prop("disabled", false);
                }
            });
        });
        $("#customer-help").click(function () {
            $("#customerName").val($("#customer-help").text());
        });
    });

</script>
</body>
</html>