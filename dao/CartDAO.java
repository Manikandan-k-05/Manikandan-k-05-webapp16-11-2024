package dao;

import bean.CartItem;
import db.DBconnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
	public boolean addCartItem(CartItem cartItem) {
	    boolean success = false;

	    // Debugging: Print the userRegID being checked
	    System.out.println("Checking if user with ID " + cartItem.getUserRegID() + " exists.");

	    // Check if the userRegID exists in the userregistration table
	    if (!userExists(cartItem.getUserRegID())) {
	        System.out.println("User does not exist.");
	        return false; // Or handle this case appropriately
	    }

	    // Calculate the total price (quantity * price)
	    double totalPrice = cartItem.getQuantity() * cartItem.getPrice();

	    // Check if the CartItem already exists
	    CartItem existingItem = getCartItem(cartItem.getUserRegID(), cartItem.getProductId());
	    if (existingItem != null) {
	        // If item exists, update it
	        success = updateCartItem(cartItem);
	    } else {
	        String sql = "INSERT INTO cartitem (userRegID, productId, quantity, price, productName) VALUES (?, ?, ?, ?, ?)";
	        try (Connection connection = DBconnection.getConnection();
	             PreparedStatement stmt = connection.prepareStatement(sql)) {

	            stmt.setInt(1, cartItem.getUserRegID());
	            stmt.setInt(2, cartItem.getProductId());
	            stmt.setInt(3, cartItem.getQuantity());
	            stmt.setDouble(4, totalPrice); // Save total price instead of unit price
	            stmt.setString(5, cartItem.getProductName());

	            int rowsAffected = stmt.executeUpdate();
	            if (rowsAffected > 0) {
	                success = true;
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return success;
	}


	// Method to check if a user exists in the userregistration table
	private boolean userExists(int userRegID) {
	    String sql = "SELECT COUNT(*) FROM userregistration WHERE userRegID = ?";
	    try (Connection connection = DBconnection.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql)) {
	        
	        stmt.setInt(1, userRegID);
	        ResultSet rs = stmt.executeQuery();
	        
	        if (rs.next()) {
	            int count = rs.getInt(1);
	            return count > 0;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}


    // Method to get a CartItem by userRegID and productId
    public CartItem getCartItem(int userRegID, int productId) {
        CartItem cartItem = null;
        String sql = "SELECT * FROM cartitem WHERE userRegID = ? AND productId = ?";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, userRegID);
            stmt.setInt(2, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                cartItem = new CartItem();
                cartItem.setUserRegID(rs.getInt("userRegID"));
                cartItem.setProductId(rs.getInt("productId"));
                cartItem.setProductName(rs.getString("productName"));
                cartItem.setQuantity(rs.getInt("quantity"));
                cartItem.setPrice(rs.getDouble("price"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartItem;
    }

    // Method to update a CartItem in the database
    public boolean updateCartItem(CartItem cartItem) {
        boolean success = false;
        String sql = "UPDATE cartitem SET quantity = ?, price = ?, productName = ? WHERE userRegID = ? AND productId = ?";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, cartItem.getQuantity());
            stmt.setDouble(2, cartItem.getPrice());
            stmt.setString(3, cartItem.getProductName());
            stmt.setInt(4, cartItem.getUserRegID());
            stmt.setInt(5, cartItem.getProductId());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                success = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }

    // Method to delete a CartItem from the database
    public boolean deleteCartItem(int userRegID, int productId) {
        boolean success = false;
        String sql = "DELETE FROM cartitem WHERE userRegID = ? AND productId = ?";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, userRegID);
            stmt.setInt(2, productId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                success = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }

    // Method to get all cart items for a user
    public List<CartItem> getAllCartItems(int userRegID) {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT * FROM cartitem WHERE userRegID = ?";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, userRegID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                CartItem cartItem = new CartItem();
                cartItem.setUserRegID(rs.getInt("userRegID"));
                cartItem.setProductId(rs.getInt("productId"));
                cartItem.setProductName(rs.getString("productName"));
                cartItem.setQuantity(rs.getInt("quantity"));
                cartItem.setPrice(rs.getDouble("price"));
                cartItems.add(cartItem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartItems;
    }

    // Method to get the total price of all cart items for a user
    public double getTotalPrice(int userRegID) {
        double total = 0.0;
        String sql = "SELECT quantity, price FROM cartitem WHERE userRegID = ?";
        
        try (Connection connection = DBconnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
             
            stmt.setInt(1, userRegID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                int quantity = rs.getInt("quantity");
                double price = rs.getDouble("price");
                total += quantity * price;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return total;
    }
}
