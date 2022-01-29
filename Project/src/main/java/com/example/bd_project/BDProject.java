package com.example.bd_project;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

public class BDProject extends Application
{
    @Override
    public void start(Stage stage) throws IOException
    {
        FXMLLoader fxmlLoader = new FXMLLoader(BDProject.class.getResource("main.fxml"));
        Scene scene = new Scene(fxmlLoader.load(), 1000, 600);
        stage.setTitle("Bazy danych - projekt");
        stage.setScene(scene);
        stage.show();
    }

    public static void main(String[] args)
    {
        String url = args.length >= 1 ? args[0] : "jdbc:postgresql://localhost:5432/db_project";
        String user = args.length >= 2 ? args[0] : "db_project_role";
        String password = args.length >= 3 ? args[0] : "password";
        DatabaseController.setConnectionParams(url, user, password);

        launch();
    }
}