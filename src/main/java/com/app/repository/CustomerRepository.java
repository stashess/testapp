package com.app.repository;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public class CustomerRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;

    public Double getAmount(String customerName) {
        Double aDouble = jdbcTemplate.query("SELECT SUM(PAYMENTS.amount)" +
                        "FROM CUSTOMERS LEFT JOIN PAYMENTS ON CUSTOMERS.customernumber = PAYMENTS.customernumber " +
                        "WHERE CUSTOMERS.customername = ?" +
                        "GROUP BY CUSTOMERS.customername", new String[]{customerName},
                (resultSet, i) -> resultSet.getDouble(1)).stream().findFirst().orElse(new Double(0));
        return aDouble;
    }


}
