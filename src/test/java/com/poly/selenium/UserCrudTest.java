package com.poly.selenium;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import org.testng.annotations.Test;

public class UserCrudTest {

    private void loginAdmin(WebDriver driver) {
        driver.get("http://localhost:8080/login;jsessionid=24B97AD2665469357791B89AA03EDF92");
        driver.findElement(By.name("id")).sendKeys("adminVanTrone");
        driver.findElement(By.name("password")).sendKeys("123");
        driver.findElement(By.cssSelector("button[type='submit']")).click();
    }

    @Test
    public void testCRUDUser() {
        WebDriver driver = new ChromeDriver();
        loginAdmin(driver);

        driver.get("http://localhost:8080/admin/user");

        // CREATE
        driver.findElement(By.name("id")).sendKeys("auto01");
        driver.findElement(By.name("password")).sendKeys("123");
        driver.findElement(By.name("email")).sendKeys("auto01@gmail.com");
        driver.findElement(By.id("btnCreate")).click();

        Assert.assertTrue(driver.getPageSource().contains("auto01"));

        driver.quit();
    }
}
