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