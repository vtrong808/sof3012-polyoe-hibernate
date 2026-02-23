package com.poly.selenium;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

public class LoginSeleniumTest {

    private WebDriver driver;

    @BeforeMethod
    public void setup() {
        driver = new ChromeDriver();
        driver.get("http://localhost:8080/login;jsessionid=24B97AD2665469357791B89AA03EDF92");
    }

    @Test
    public void TC01_loginSuccess() {
        driver.findElement(By.name("id")).sendKeys("adminVanTrone");
        driver.findElement(By.name("password")).sendKeys("123");
        driver.findElement(By.cssSelector("button[type='submit']")).click();

        Assert.assertTrue(driver.getCurrentUrl().contains("/home"));
    }

    @Test
    public void TC02_loginFail() {
        driver.findElement(By.name("id")).sendKeys("admin");
        driver.findElement(By.name("password")).sendKeys("wrong");
        driver.findElement(By.cssSelector("button[type='submit']")).click();

        Assert.assertTrue(driver.getPageSource().contains("Sai thông tin"));
    }

    @AfterMethod
    public void tearDown() {
        driver.quit();
    }
}
