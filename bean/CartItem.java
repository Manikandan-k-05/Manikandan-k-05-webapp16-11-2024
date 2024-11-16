package bean;

public class CartItem {

    private int userRegID;  // Added userRegID to link cart item to user
    private int productId;
    private String productName;
    private int quantity;
    private double price;

    // Constructor with all fields, including userRegID
    public CartItem(int userRegID, int productId, String productName, int quantity, double price) {
        this.userRegID = userRegID;
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
    }

    // Constructor without productName (since it might not always be available immediately)
    public CartItem(int userRegID, int productId, int quantity, double price) {
        this.userRegID = userRegID;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
    }

    // Default Constructor (if required)
    public CartItem() {
        // You can leave this empty or initialize default values
    }

    // Getters and Setters for userRegID, productId, productName, quantity, and price
    public int getUserRegID() {
        return userRegID;
    }

    public void setUserRegID(int userRegID) {
        this.userRegID = userRegID;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    // Optional: ToString method for easy representation of CartItem
    @Override
    public String toString() {
        return "CartItem{" +
                "userRegID=" + userRegID +
                ", productId=" + productId +
                ", productName='" + productName + '\'' +
                ", quantity=" + quantity +
                ", price=" + price +
                '}';
    }
}
