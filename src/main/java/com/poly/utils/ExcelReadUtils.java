package com.poly.utils;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileInputStream;

public class ExcelReadUtils {

    // Hàm đọc dữ liệu từ file Excel và trả về mảng 2 chiều
    public static Object[][] getExcelData(String filePath, String sheetName) {
        Object[][] data = null;
        try {
            FileInputStream fis = new FileInputStream(filePath);
            Workbook workbook = new XSSFWorkbook(fis);
            Sheet sheet = workbook.getSheet(sheetName);

            int rowCount = sheet.getLastRowNum(); // Bỏ dòng tiêu đề (Header)
            int colCount = sheet.getRow(0).getLastCellNum();

            data = new Object[rowCount][colCount];

            // Bắt đầu đọc từ dòng số 1 (dòng 0 là Header)
            for (int i = 1; i <= rowCount; i++) {
                Row row = sheet.getRow(i);
                for (int j = 0; j < colCount; j++) {
                    Cell cell = row.getCell(j);
                    // DataFormatter giúp lấy dữ liệu dưới dạng String (dù là số hay chữ)
                    data[i - 1][j] = new DataFormatter().formatCellValue(cell);
                }
            }
            workbook.close();
            fis.close();
        } catch (Exception e) {
            System.out.println("Lỗi đọc file Excel: " + e.getMessage());
        }
        return data;
    }
}