package com.example.bd_project;

import javafx.beans.property.SimpleStringProperty;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.util.Callback;

import java.time.ZoneId;
import java.util.ArrayList;

public class Controller
{
    private DatabaseController db;

    @FXML
    private TextField addAddressCity;

    @FXML
    private TextField addAddressPostalCode;

    @FXML
    private TextField addAddressStreet;

    @FXML
    private TextField addAddressBuilding;

    @FXML
    private Label addressErrorLabel;

    @FXML
    private TableView<Address> addressTable;

    @FXML
    private TextField addVendorName;

    @FXML
    private TextField addVendorIdAddress;

    @FXML
    private Label vendorErrorLabel;

    @FXML
    private TableView<Vendor> vendorTable;

    @FXML
    private TextField addClientFirstName;

    @FXML
    private TextField addClientLastName;

    @FXML
    private TextField addClientIdAddress;

    @FXML
    private TextField addClientEmail;

    @FXML
    private TextField addClientPhone;

    @FXML
    private Label clientErrorLabel;

    @FXML
    private TableView<Client> clientTable;

    @FXML
    private TextField addEmployeeFirstName;

    @FXML
    private TextField addEmployeeLastName;

    @FXML
    private TextField addEmployeeRole;

    @FXML
    private TextField addEmployeeIdAddress;

    @FXML
    private TextField addEmployeeEmail;

    @FXML
    private TextField addEmployeePhone;

    @FXML
    private TextField addEmployeeAccount;

    @FXML
    private Label employeeErrorLabel;

    @FXML
    private TableView<Employee> employeeTable;

    @FXML
    private TextField addProductPrice;

    @FXML
    private TextField addProductVatRate;

    @FXML
    private TextField addProductName;

    @FXML
    private TextField addProductIdVendor;

    @FXML
    private Label productErrorLabel;

    @FXML
    private TableView<Product> productTable;

    @FXML
    private TextField addAvailabilityQuantity;

    @FXML
    private TextField addAvailabilityIdProduct;

    @FXML
    private Label availabilityErrorLabel;

    @FXML
    private TableView<Availability> availabilityTable;

    @FXML
    private TextField addPromoCodePercent;

    @FXML
    private TextField addPromoCodeAmount;

    @FXML
    private TextField addPromoCodeCode;

    @FXML
    private TextField addPromoCodeLimit;

    @FXML
    private TextField addPromoCodeUsed;

    @FXML
    private TextField addPromoCodeIdEmployee;

    @FXML
    private Label promoCodeErrorLabel;

    @FXML
    private TableView<PromoCode> promoCodeTable;

    @FXML
    private TextField addCartIdClient;

    @FXML
    private Label cartErrorLabel;

    @FXML
    private TableView<Cart> cartTable;

    @FXML
    private TextField addCartProductIdClient;

    @FXML
    private TextField addCartProductIdProduct;

    @FXML
    private TextField addCartProductQuantity;

    @FXML
    private Label cartProductErrorLabel;

    @FXML
    private TableView<CartProduct> cartProductTable;

    @FXML
    private TextField addPurchaseQuantity;

    @FXML
    private TextField addPurchaseIdProduct;

    @FXML
    private TextField addPurchaseIdClient;

    @FXML
    private TextField addPurchaseIdPromoCode;

    @FXML
    private TextField addPurchaseOrderNum;

    @FXML
    private TextField addPurchaseIdEmployee;

    @FXML
    private DatePicker addPurchaseDate;

    @FXML
    private Label purchaseErrorLabel;

    @FXML
    private TableView<Purchase> purchaseTable;

    @FXML
    public void initialize()
    {
        db = new DatabaseController();
    }

    @FXML
    protected void addAddressButtonOnAction()
    {
        String city = addAddressCity.getText();
        String postalCode = addAddressPostalCode.getText();
        String street = addAddressStreet.getText();
        String building = addAddressBuilding.getText();

        String result = db.insertAddress(city, postalCode, street, building);
        addressErrorLabel.setText(result);
        addressErrorLabel.setVisible(!result.equals(""));
    }

    @FXML
    protected void addVendorButtonOnAction()
    {
        String name = addVendorName.getText();
        String idAddress = addVendorIdAddress.getText();

        String result = db.insertVendor(name, idAddress);
        vendorErrorLabel.setText(result);
        vendorErrorLabel.setVisible(!result.equals(""));
    }

    @FXML
    protected void addClientButtonOnAction()
    {
        String firstName = addClientFirstName.getText();
        String lastName = addClientLastName.getText();
        String idAddress = addClientIdAddress.getText();
        String email = addClientEmail.getText();
        String phone = addClientPhone.getText();

        String result = db.insertClient(firstName, lastName, idAddress, email, phone);
        clientErrorLabel.setText(result);
        clientErrorLabel.setVisible(!result.equals(""));
    }

    @FXML
    protected void addEmployeeButtonOnAction()
    {
        String firstName = addEmployeeFirstName.getText();
        String lastName = addEmployeeLastName.getText();
        String role = addEmployeeRole.getText();
        String idAddress = addEmployeeIdAddress.getText();
        String email = addEmployeeEmail.getText();
        String phone = addEmployeePhone.getText();
        String account = addEmployeeAccount.getText();

        String result = db.insertEmployee(firstName, lastName, role, idAddress, email, phone, account);
        employeeErrorLabel.setText(result);
        employeeErrorLabel.setVisible(!result.equals(""));
    }

    @FXML
    protected void addProductButtonOnAction()
    {
        String price = addProductPrice.getText();
        String vatRate = addProductVatRate.getText();
        String name = addProductName.getText();
        String idVendor = addProductIdVendor.getText();

        String result = db.insertProduct(price, vatRate, name, idVendor);
        productErrorLabel.setText(result);
        productErrorLabel.setVisible(!result.equals(""));
    }

    @FXML
    protected void addAvailabilityButtonOnAction()
    {
        String quantity = addAvailabilityQuantity.getText();
        String idProduct = addAvailabilityIdProduct.getText();

        String result = db.insertAvailability(quantity, idProduct);
        availabilityErrorLabel.setText(result);
        availabilityErrorLabel.setVisible(!result.equals(""));
    }

    @FXML
    protected void addPromoCodeButtonOnAction()
    {
        String percent = addPromoCodePercent.getText();
        String amount = addPromoCodeAmount.getText();
        String code = addPromoCodeCode.getText();
        String limit = addPromoCodeLimit.getText();
        String used = addPromoCodeUsed.getText();
        String idEmployee = addPromoCodeIdEmployee.getText();

        String result = db.insertPromoCode(percent, amount, code, limit, used, idEmployee);
        promoCodeErrorLabel.setText(result);
        promoCodeErrorLabel.setVisible(!result.equals(""));
    }

    @FXML
    protected void addCartButtonOnAction()
    {
        String idClient = addCartIdClient.getText();

        String result = db.insertCart(idClient);
        cartErrorLabel.setText(result);
        cartErrorLabel.setVisible(!result.equals(""));
    }

    @FXML
    protected void addCartProductButtonOnAction()
    {
        String idClient = addCartProductIdClient.getText();
        String idProduct = addCartProductIdProduct.getText();
        String quantity = addCartProductQuantity.getText();

        String result = db.insertCartProduct(idClient, idProduct, quantity);
        cartProductErrorLabel.setText(result);
        cartProductErrorLabel.setVisible(!result.equals(""));
    }

    @FXML
    protected void addPurchaseButtonOnAction()
    {
        String quantity = addPurchaseQuantity.getText();
        String idProduct = addPurchaseIdProduct.getText();
        String idClient = addPurchaseIdClient.getText();
        String idPromoCode = addPurchaseIdPromoCode.getText();
        String orderNum = addPurchaseOrderNum.getText();
        String idEmployee = addPurchaseIdEmployee.getText();

        String result;
        if(addPurchaseDate.getValue() != null)
        {
            java.util.Date date = java.util.Date.from(addPurchaseDate.getValue().atStartOfDay(ZoneId.systemDefault()).toInstant());
            result = db.insertPurchase(quantity, idProduct, idClient, idPromoCode, orderNum, idEmployee, date);
        }
        else
        {
            result = "Date missing";
        }

        purchaseErrorLabel.setText(result);
        purchaseErrorLabel.setVisible(!result.equals(""));
    }

    @FXML
    protected void showAddressTableOnAction()
    {
        populateTable(addressTable, new Address());
    }

    @FXML
    protected void showVendorTableOnAction()
    {
        populateTable(vendorTable, new Vendor());
    }

    @FXML
    protected void showClientTableOnAction()
    {
        populateTable(clientTable, new Client());
    }

    @FXML
    protected void showEmployeeTableOnAction()
    {
        populateTable(employeeTable, new Employee());
    }

    @FXML
    protected void showProductTableOnAction()
    {
        populateTable(productTable, new Product());
    }

    @FXML
    protected void showAvailabilityTableOnAction()
    {
        populateTable(availabilityTable, new Availability());
    }

    @FXML
    protected void showPromoCodeTableOnAction()
    {
        populateTable(promoCodeTable, new PromoCode());
    }

    @FXML
    protected void showCartTableOnAction()
    {
        populateTable(cartTable, new Cart());
    }

    @FXML
    protected void showCartProductTableOnAction()
    {
        populateTable(cartProductTable, new CartProduct());
    }

    @FXML
    protected void showPurchaseTableOnAction()
    {
        populateTable(purchaseTable, new Purchase());
    }

    private <T> void populateTable(TableView<T> tableView, TableElement instance)
    {
        ArrayList<T> list = (ArrayList<T>) db.selectAll(instance.getClass());

        ObservableList<T> data = FXCollections.observableArrayList();
        data.addAll(list);
        tableView.setItems(data);

        tableView.getColumns().clear();
        for(int i = 0; i < instance.getColumnCount(); i++)
        {
            final int c = i;
            TableColumn<T, String> column = new TableColumn<T, String>(instance.getColumnName(c));
            column.setCellValueFactory(new Callback<TableColumn.CellDataFeatures<T, String>, ObservableValue<String>>() {
                @Override
                public ObservableValue<String> call(TableColumn.CellDataFeatures<T, String> features) {
                    return new SimpleStringProperty(((TableElement)features.getValue()).getColumn(c));
                }
            });
            tableView.getColumns().add(column);
        }
    }
}