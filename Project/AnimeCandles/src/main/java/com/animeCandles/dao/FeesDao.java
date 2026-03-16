package com.animeCandles.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class FeesDao {

    private final Connection con;

    public FeesDao(Connection con) {
        this.con = con;
    }

    // Devuelve shipping y packaging en un float[2]
    // index 0 = shipping, index 1 = packaging
    public float[] getFees() {
        float[] fees = new float[] {0.0f, 0.0f};

        String sql = "SELECT shipping_fee, packaging_fee FROM fees ORDER BY fid ASC LIMIT 1";

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                fees[0] = rs.getFloat("shipping_fee");
                fees[1] = rs.getFloat("packaging_fee");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return fees;
    }

    // Actualiza fees del registro id=1 (o el primero)
    public boolean updateFees(float shippingFee, float packagingFee) {
        // Si solo tendrás una fila fija, usa id=1:
        String sql = "UPDATE fees SET shipping_fee = ?, packaging_fee = ? WHERE fid = 1";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setFloat(1, shippingFee);
            ps.setFloat(2, packagingFee);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
