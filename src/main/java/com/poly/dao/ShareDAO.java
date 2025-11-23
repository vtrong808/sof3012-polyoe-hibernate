package com.poly.dao;

import com.poly.entity.Share;
import com.poly.utils.JpaUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class ShareDAO implements AutoCloseable {
    private EntityManager em = JpaUtils.getEntityManager();

    @Override
    public void close() {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }

    // Lưu thông tin chia sẻ
    public void create(Share entity) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(entity);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw new RuntimeException(e);
        }
    }

    // Các hàm mở rộng sau này (nếu cần): đếm số lượt share, list share...
}