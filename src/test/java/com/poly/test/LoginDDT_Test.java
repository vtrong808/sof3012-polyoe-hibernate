package com.poly.test;

import com.poly.utils.ExcelReadUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import org.testng.ITestResult;
import org.testng.annotations.*;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.time.Duration;

public class LoginDDT_Test {

    WebDriver driver;
    String URL_LOGIN = "http://localhost:8080/login";

    @BeforeMethod
    public void setup() {
        driver = new ChromeDriver();
        driver.manage().window().maximize();
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(5));
    }

    // CUNG CẤP DỮ LIỆU: Lấy data từ file Excel
    @DataProvider(name = "loginDataFromExcel")
    public Object[][] getLoginData() {
        return ExcelReadUtils.getExcelData("TestData.xlsx", "LoginData");
    }

    // CHẠY TEST TỰ ĐỘNG THEO DỮ LIỆU TỪ EXCEL
    @Test(dataProvider = "loginDataFromExcel")
    public void testLoginWithExcel(String username, String password, String expectedStatus) {
        System.out.println("-> Đang test tài khoản: " + username + " / " + password);
        driver.get(URL_LOGIN);

        // Nhập data từ Excel vào Web
        driver.findElement(By.name("id")).sendKeys(username);
        driver.findElement(By.name("password")).sendKeys(password);
        driver.findElement(By.tagName("button")).click();

        // Kiểm tra kết quả
        String currentUrl = driver.getCurrentUrl();
        if (expectedStatus.equalsIgnoreCase("Pass")) {
            // Mong đợi Pass -> Phải chuyển hướng khỏi trang login
            Assert.assertFalse(currentUrl.contains("login"), "Lỗi: Tài khoản đúng nhưng không đăng nhập được!");
        } else {
            // Mong đợi Fail -> Phải ở lại trang login
            Assert.assertTrue(currentUrl.contains("login"), "Lỗi: Tài khoản sai nhưng lại đăng nhập thành công!");
        }
    }

    // CHỤP ẢNH MÀN HÌNH SAU KHI TEST XONG (Pass/Fail đều chụp)
    @AfterMethod
    public void tearDownAndTakeScreenshot(ITestResult result) {
        if (driver != null) {
            try {
                // Tạo thư mục "screenshots" nếu chưa có
                File screenshotDir = new File("screenshots");
                if (!screenshotDir.exists()) {
                    screenshotDir.mkdirs();
                }

                // Chụp ảnh màn hình
                TakesScreenshot ts = (TakesScreenshot) driver;
                File sourceFile = ts.getScreenshotAs(OutputType.FILE);

                // Đặt tên file ảnh chứa Tên Test + Status (PASS/FAIL) + Thời gian
                String status = (result.getStatus() == ITestResult.SUCCESS) ? "PASS" : "FAIL";
                // Lấy ra các tham số truyền vào từ Excel (ví dụ: admin) để nối vào tên ảnh
                String testDataParam = (result.getParameters().length > 0) ? "_" + result.getParameters()[0].toString() : "";

                String fileName = "screenshots/" + status + "_" + result.getMethod().getMethodName() + testDataParam + "_" + System.currentTimeMillis() + ".png";
                File destFile = new File(fileName);

                // Lưu ảnh vào thư mục
                Files.copy(sourceFile.toPath(), destFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                System.out.println("📸 Đã lưu ảnh màn hình: " + destFile.getAbsolutePath());

            } catch (Exception e) {
                System.out.println("Lỗi khi chụp ảnh màn hình: " + e.getMessage());
            } finally {
                driver.quit();
            }
        }
    }
}