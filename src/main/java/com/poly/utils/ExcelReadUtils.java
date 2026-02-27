package com.poly.utils;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileInputStream;

public class ExcelReadUtils {

    // Đổi tên hàm thành readExcel (hoặc bạn giữ nguyên thì sửa lại ở các file Test)
    public static Object[][] readExcel(String filePath, String sheetName) {
        Object[][] data = null;
        try {
            FileInputStream fis = new FileInputStream(filePath);
            Workbook workbook = new XSSFWorkbook(fis);
            Sheet sheet = workbook.getSheet(sheetName);

            if (sheet == null) {
                System.out.println("Không tìm thấy sheet: " + sheetName);
                return new Object[0][0];
            }

            int rowCount = sheet.getLastRowNum(); // Bỏ dòng tiêu đề (Header)
            int colCount = sheet.getRow(0).getLastCellNum();

            data = new Object[rowCount][colCount];
            DataFormatter formatter = new DataFormatter();

            // Bắt đầu đọc từ dòng số 1 (dòng 0 là Header)
            for (int i = 1; i <= rowCount; i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue; // Bỏ qua nếu dòng trống hoàn toàn

                for (int j = 0; j < colCount; j++) {
                    // Tránh lỗi NullPointerException nếu ô bị bỏ trống
                    Cell cell = row.getCell(j, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);

                    // Format lấy giá trị dạng String
                    String cellValue = formatter.formatCellValue(cell).trim();

                    // QUAN TRỌNG: Chuyển đổi từ khóa NULL_VAL thành null thực sự trong Java
                    if ("NULL_VAL".equals(cellValue)) {
                        data[i - 1][j] = null;
                    } else {
                        data[i - 1][j] = cellValue;
                    }
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