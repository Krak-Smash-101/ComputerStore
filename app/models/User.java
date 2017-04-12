package models;

import java.util.*;
import javax.persistence.*;
import com.avaje.ebean.Model;
import org.mindrot.jbcrypt.BCrypt;
import play.data.format.*;
import play.data.validation.*;
import play.Logger;
import models.*;
import models.*;

@Entity
public class User extends Model{

    @Id
    private String email;
    @Constraints.Required
    private String firstName;
    @Constraints.Required
    private String lastName;
    private String role;
    @Constraints.Required
    private String password;
    @Constraints.Required
    private String address;
    @Constraints.Required
    private int age;
    @Constraints.Required
    private String phone,mobile;
    @Formats.DateTime(pattern="dd/MM/yyyy")
    private Date joinDate = new Date();

    @OneToOne(mappedBy="user", cascade = CascadeType.ALL)
    private Basket basket;

    @OneToOne(mappedBy="user", cascade = CascadeType.ALL)
    private Wishlist wishlist;

    @OneToMany(mappedBy = "user",cascade = CascadeType.ALL)
    private List<ShopOrder> orders;

    public User(){
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public Wishlist getWishlist() {
        return wishlist;
    }

    public void setWishlist(Wishlist wishlist) {
        this.wishlist = wishlist;
    }

    public Basket getBasket() {
        return basket;
    }

    public void setBasket(Basket basket) {
        this.basket = basket;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(Date joinDate) {
        this.joinDate = joinDate;
    }

    public List<ShopOrder> getOrders() {
        return orders;
    }

    public void setOrders(List<ShopOrder> orders) {
        this.orders = orders;
    }

    public static Finder<String,User> find = new Finder<String,User>(User.class);

    public static List<User> findAll() {
        return User.find.all();
    }

    public static User authenticate(String email, String password){
        User user = User.find.where().eq("email", email).findUnique();
        if (user != null && BCrypt.checkpw(password, user.password)) {
            return user;
        } else {
            return null;
        }
    }

    public static User getUserById(String id){
        if (id == null){
            return null;
        }else{
            return find.byId(id);
        }
    }
    public static void deleteUser(String email){
        find.ref(email).delete();
    }
}


