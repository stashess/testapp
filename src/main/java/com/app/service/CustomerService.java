package com.app.service;


import com.app.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerService {

    @Autowired
    CustomerRepository customerRepository;

    public Double getAmount(String customerName){
        return customerRepository.getAmount(customerName);
    }

}
