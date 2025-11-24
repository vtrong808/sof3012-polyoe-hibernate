package com.poly.dao;

import com.poly.utils.JpaUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class ReportDAO implements AutoCloseable{
    private EntityManager em = JpaUtils.getEntityManager();

    @Override
    public void close() {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }

    // 1. Đếm tổng số Video
    public Long countVideos() {
        String jpql = "SELECT count(v) FROM Video v";
        TypedQuery<Long> query = em.createQuery(jpql, Long.class);
        return query.getSingleResult();
    }

    // 2. Đếm tổng số User
    public Long countUsers() {
        String jpql = "SELECT count(u) FROM User u";
        TypedQuery<Long> query = em.createQuery(jpql, Long.class);
        return query.getSingleResult();
    }

    // 3. Tính tổng lượt xem (Views)
    public Long totalViews() {
        String jpql = "SELECT sum(v.views) FROM Video v";
        TypedQuery<Long> query = em.createQuery(jpql, Long.class);
        Long total = query.getSingleResult();
        return total == null ? 0 : total;
    }

    // 4. Đếm tổng lượt thích (Favorite)
    public Long countFavorites() {
        String jpql = "SELECT count(f) FROM Favorite f";
        TypedQuery<Long> query = em.createQuery(jpql, Long.class);
        return query.getSingleResult();
    }

    // 5. Thống kê Báo cáo: Favorites (Video Title, Count, Newest, Oldest)
    public List<Object[]> getFavorites() {
        String jpql = "SELECT f.video.title, count(f), max(f.likeDate), min(f.likeDate) " +
                "FROM Favorite f GROUP BY f.video.title";
        TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
        return query.getResultList();
    }

    // 6. Thống kê Báo cáo: Favorite Users (Username, Fullname, Email, LikeDate)
    public List<Object[]> getFavoriteUsers(String videoId) {
        String jpql = "SELECT f.user.id, f.user.fullname, f.user.email, f.likeDate " +
                "FROM Favorite f WHERE f.video.id = :vid";
        TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
        query.setParameter("vid", videoId);
        return query.getResultList();
    }

    // 7. Thống kê Báo cáo: Shared Friends (Sender Name, Sender Email, Receiver Email, Sent Date)
    public List<Object[]> getShareFriends(String videoId) {
        String jpql = "SELECT s.user.fullname, s.user.email, s.emails, s.shareDate " +
                "FROM Share s WHERE s.video.id = :vid";
        TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
        query.setParameter("vid", videoId);
        return query.getResultList();
    }
}