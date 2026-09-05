package com.example.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

import java.io.Serializable;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.Date;
import java.util.Locale;

@Entity
@Table(name = "products")
@NamedQueries({
        @NamedQuery(name = "Product.findLatest", query = "SELECT p FROM Product p ORDER BY p.createdDate DESC, p.id DESC"),
        @NamedQuery(name = "Product.findPage", query = "SELECT p FROM Product p ORDER BY p.createdDate DESC, p.id DESC")
})
public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ProductId")
    private int id;

    @Column(name = "ProductName", nullable = false, length = 255)
    private String name;

    @Column(name = "Description", length = 2000)
    private String description;

    @Column(name = "Price", nullable = false, precision = 11, scale = 2)
    private BigDecimal price;

    @Column(name = "Images", length = 500)
    private String image;

    @Column(name = "Quantity", nullable = false)
    private int quantity;

    @Column(name = "CreatedDate", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "CategoryId", nullable = false)
    private Category category;

    public Product() {
    }

    public Product(String name, String description, BigDecimal price, String image, int quantity, Date createdDate, Category category) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.image = image;
        this.quantity = quantity;
        this.createdDate = createdDate;
        this.category = category;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public String getFormattedPrice() {
        if (price == null) {
            return "";
        }
        return NumberFormat.getNumberInstance(Locale.forLanguageTag("vi-VN")).format(price);
    }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
}
