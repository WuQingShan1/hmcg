package com.yjxxt.crm;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Hello world!
 *
 */
@SpringBootApplication
@MapperScan("com.yjxxt.crm.dao")
public class App {
    public static void main( String[] args ){
        SpringApplication.run(App.class);
    }
}
