package com.app.controller.rest;


import com.app.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/customers")
public class CustomerRestController {

    @Autowired
    CustomerService customerService;

    @GetMapping(value = "/amount")
    public Double getAmount(@RequestParam String customerName){
        return customerService.getAmount(customerName);
    }


}
