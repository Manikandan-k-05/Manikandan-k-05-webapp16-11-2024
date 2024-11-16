<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*, org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*, bean.ProductBean, dao.ProductDAO"%>
<%
String productName = "";
String category = "";
double price = 0;
String stockStatus = "";
String description = "";
String fileName = "";
int productId = 0;

if (ServletFileUpload.isMultipartContent(request)) {
    DiskFileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);

    try {
        List<FileItem> formItems = upload.parseRequest(request);
        ProductDAO productDAO = new ProductDAO();
        String currentImage = null;

        for (FileItem item : formItems) {
            if (item.isFormField()) {
                String fieldName = item.getFieldName();
                String fieldValue = item.getString();

                switch (fieldName) {
                    case "productName":
                        productName = fieldValue;
                        break;
                    case "category":
                        category = fieldValue;
                        break;
                    case "price":
                        price = Double.parseDouble(fieldValue);
                        break;
                    case "stock":
                        stockStatus = fieldValue;
                        break;
                    case "description":
                        description = fieldValue;
                        break;
                    case "productId":
                        productId = Integer.parseInt(fieldValue);
                        break;
                    case "currentProductImage":
                        currentImage = fieldValue;
                        break;
                }
            } else {
                if (item.getName() != null && !item.getName().isEmpty()) {
                    fileName = System.currentTimeMillis() + "_" + item.getName();
                    String uploadPath = getServletContext().getRealPath("/") + "uploads/";
                    File uploadDir = new File(uploadPath);

                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    String filePath = uploadPath + fileName;
                    item.write(new File(filePath));
                }
            }
        }

        // Retain current image if no new image is uploaded
        if (fileName.isEmpty() && currentImage != null && !currentImage.isEmpty()) {
            fileName = currentImage;
        } else if (fileName.isEmpty()) {
            fileName = "default.jpg";
        }

        ProductBean product = productDAO.getProductsById(productId);
        if (product == null) {
            out.println("Error: Product not found.");
            return;
        }

        product.setProductId(productId);
        product.setProductName(productName);
        product.setCategory(category);
        product.setPrice(price);
        product.setStock(stockStatus);
        product.setDescription(description);
        product.setProductImage(fileName);

        boolean isUpdated = productDAO.updateProduct(product);

        if (isUpdated) {
%>
<script>
    alert("Product updated successfully!");
    window.location.href = "productManage.jsp";
</script>
<%
        } else {
%>
<script>
    alert("Failed to update product.");
    window.location.href = "editProduct.jsp?productId=<%=productId%>";
</script>
<%
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        out.println("Error: " + ex.getMessage());
    }
}
%>
