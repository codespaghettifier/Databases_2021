module com.example.bd_project {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.sql;


    opens com.example.bd_project to javafx.fxml;
    exports com.example.bd_project;
}