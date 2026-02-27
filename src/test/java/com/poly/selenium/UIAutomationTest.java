package com.poly.selenium;

import org.openqa.selenium.By;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.util.Date;

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

    // Hàm hỗ trợ chụp ảnh màn hình
    private void takeScreenshot(String stepName) {
        try {
            TakesScreenshot ts = (TakesScreenshot) driver;
            File source = ts.getScreenshotAs(OutputType.FILE);

            // Tạo tên file có kèm thời gian để không bị ghi đè
            String timestamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
            File target = new File("screenshots/" + stepName + "_" + timestamp + ".png");

            // Tạo thư mục screenshots nếu chưa có
            target.getParentFile().mkdirs();

            // Lưu file ảnh
            Files.copy(source.toPath(), target.toPath(), StandardCopyOption.REPLACE_EXISTING);
            System.out.println("Đã chụp ảnh màn hình: " + target.getAbsolutePath());
        } catch (Exception e) {
            System.out.println("Lỗi khi chụp ảnh màn hình: " + e.getMessage());
        }
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

        Assert.assertTrue(driver.getCurrentUrl().contains("/admin"), "Đăng nhập thất bại, không vào được trang admin");

        // 📸 CHỤP ẢNH: Sau khi đăng nhập thành công
        takeScreenshot("1_SauDangNhap");
    }

    @Test(priority = 3)
    public void testCRUD_User() throws InterruptedException {
        driver.get(BASE_URL + "/admin/user");
        Thread.sleep(1000);

        // --- 1. CREATE (Thêm) ---
        driver.findElement(By.name("id")).sendKeys("auto01");
        driver.findElement(By.name("password")).sendKeys("123");
        driver.findElement(By.name("fullname")).sendKeys("Selenium User");
        driver.findElement(By.name("email")).sendKeys("auto01@gmail.com");

        driver.findElement(By.xpath("//button[contains(@formaction, '/create')]")).click();
        Thread.sleep(2000);

        Assert.assertTrue(driver.getPageSource().contains("auto01"), "Thêm mới thất bại");

        // 📸 CHỤP ẢNH: Sau khi Thêm mới User
        takeScreenshot("2_SauKhiThem_auto01");

        // --- 2. UPDATE (Cập nhật) ---
        driver.findElement(By.name("id")).clear();
        driver.findElement(By.name("id")).sendKeys("auto01");

        driver.findElement(By.name("password")).clear();
        driver.findElement(By.name("password")).sendKeys("123456");

        driver.findElement(By.name("fullname")).clear();
        driver.findElement(By.name("fullname")).sendKeys("Updated User");

        driver.findElement(By.name("email")).clear();
        driver.findElement(By.name("email")).sendKeys("auto_updated@gmail.com");

        driver.findElement(By.xpath("//button[contains(@formaction, '/update')]")).click();
        Thread.sleep(2000);

        Assert.assertTrue(driver.getPageSource().contains("auto_updated@gmail.com"), "Cập nhật thất bại");

        // 📸 CHỤP ẢNH: Sau khi Sửa User
        takeScreenshot("3_SauKhiSua_auto01");

        // --- 3. DELETE (Xóa) ---
        driver.findElement(By.name("id")).clear();
        driver.findElement(By.name("id")).sendKeys("auto01");

        driver.findElement(By.xpath("//button[contains(@formaction, '/delete')]")).click();
        Thread.sleep(2000);

        Assert.assertFalse(driver.getPageSource().contains("auto_updated@gmail.com"), "Xóa thất bại");

        // 📸 CHỤP ẢNH: Sau khi Xóa User
        takeScreenshot("4_SauKhiXoa_auto01");
    }

    @AfterClass
    public void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }
}