package com.poly.dao;

import com.poly.entity.Video;
import com.poly.utils.JpaUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class VideoDAO implements AutoCloseable{
    private EntityManager em = JpaUtils.getEntityManager();

    @Override
    public void close() {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }

    public Video findById(String id) {
        return em.find(Video.class, id);
    }

    public List<Video> findAll() {
        // JPQL để lấy tất cả video đang hoạt động (Active = true)
        // Assignment yêu cầu sắp xếp giảm dần theo lượt xem (Slide 2.1 Page 6)
        String jpql = "SELECT v FROM Video v WHERE v.active = true ORDER BY v.views DESC";
        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
        return query.getResultList();
    }

    // 1. Thêm mới Video
    public void create(Video entity) {
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

    // 2. Cập nhật Video
    public void update(Video entity) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(entity);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw new RuntimeException(e);
        }
    }

    // 3. Xóa Video theo ID
    public void delete(String id) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Video entity = em.find(Video.class, id);
            if (entity != null) {
                em.remove(entity);
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw new RuntimeException(e);
        }
    }
}