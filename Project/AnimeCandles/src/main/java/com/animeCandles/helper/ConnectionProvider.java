package com.animeCandles.helper;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class ConnectionProvider {

    private static Connection connection;

    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {

                Properties props = new Properties();
                try (InputStream in = ConnectionProvider.class.getClassLoader()
                        .getResourceAsStream("db.properties")) {
                    if (in == null) {
                        throw new RuntimeException("db.properties no encontrado en classpath");
                    }
                    props.load(in);
                }

                String url = props.getProperty("db.url");
                String user = props.getProperty("db.user");
                String pass = props.getProperty("db.password");

                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(url, user, pass);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }
}
