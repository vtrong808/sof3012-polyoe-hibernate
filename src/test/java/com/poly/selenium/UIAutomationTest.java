package com.poly.selenium;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.time.Duration;

public class UIAutomationTest {
    private WebDriver driver;

    // Đảm bảo URL này khớp với server Tomcat của bạn
    private final String BASE_URL = "http://localhost:8080";

    @BeforeClass
    public void setUp() {
        driver = new ChromeDriver();
        driver.manage().window().maximize();
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));
    }

    @Test(priority = 1)
    public void testDangKy() throws InterruptedException {
        // Tạm lướt qua để tập trung vào luồng chính
        driver.get(BASE_URL + "/login");
        Thread.sleep(1000);
    }

    @Test(priority = 2)
    public void testDangNhap() throws InterruptedException {
        driver.get(BASE_URL + "/login");

        driver.findElement(By.name("id")).sendKeys("adminVanTrone");
        driver.findElement(By.name("password")).sendKeys("123");
        driver.findElement(By.cssSelector("button[type='submit']")).click();

        Thread.sleep(2000);

        // ĐÃ SỬA: Admin sẽ được đưa vào trang /admin chứ không phải /home
        Assert.assertTrue(driver.getCurrentUrl().contains("/admin"), "Đăng nhập thất bại, không vào được trang admin");
    }

    @Test(priority = 3)
    public void testCRUD_User() throws InterruptedException {
        driver.get(BASE_URL + "/admin/user");
        Thread.sleep(1000);

        // --- 1. CREATE (Thêm) ---
        driver.findElement(By.name("id")).sendKeys("auto01");
        driver.findElement(By.name("password")).sendKeys("123");
        // Bổ sung thêm trường fullname vì trong file JSP có input name="fullname" bắt buộc nhập (required)
        driver.findElement(By.name("fullname")).sendKeys("Selenium User");
        driver.findElement(By.name("email")).sendKeys("auto01@gmail.com");

        // ĐÃ SỬA: Tìm nút bằng xpath qua thuộc tính formaction='/admin/user/create'
        driver.findElement(By.xpath("//button[contains(@formaction, '/create')]")).click();

        Thread.sleep(2000);
        Assert.assertTrue(driver.getPageSource().contains("auto01"), "Thêm mới thất bại");

        // --- 2. UPDATE (Cập nhật) ---
        driver.findElement(By.name("id")).clear();
        driver.findElement(By.name("id")).sendKeys("auto01");

        driver.findElement(By.name("password")).clear();
        driver.findElement(By.name("password")).sendKeys("123456");

        driver.findElement(By.name("fullname")).clear();
        driver.findElement(By.name("fullname")).sendKeys("Updated User");

        driver.findElement(By.name("email")).clear();
        driver.findElement(By.name("email")).sendKeys("auto_updated@gmail.com");

        // ĐÃ SỬA: Tìm nút Lưu bằng xpath
        driver.findElement(By.xpath("//button[contains(@formaction, '/update')]")).click();
        Thread.sleep(2000);
        Assert.assertTrue(driver.getPageSource().contains("auto_updated@gmail.com"), "Cập nhật thất bại");

        // --- 3. DELETE (Xóa) ---
        driver.findElement(By.name("id")).clear();
        driver.findElement(By.name("id")).sendKeys("auto01");

        // ĐÃ SỬA: Tìm nút Xóa bằng xpath
        driver.findElement(By.xpath("//button[contains(@formaction, '/delete')]")).click();
        Thread.sleep(2000);
        Assert.assertFalse(driver.getPageSource().contains("auto_updated@gmail.com"), "Xóa thất bại");
    }

    @AfterClass
    public void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }
}