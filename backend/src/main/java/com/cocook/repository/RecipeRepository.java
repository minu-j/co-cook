package com.cocook.repository;

import com.cocook.entity.Recipe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface RecipeRepository extends JpaRepository<Recipe, Long> {

    @Query(value = "SELECT * FROM recipe r " +
            "JOIN tag t ON t.recipe_idx = r.recipe_idx " +
            "JOIN theme th ON t.theme_idx = th.theme_idx " +
            "WHERE th.theme_name = :themeName " +
            "ORDER BY RAND() LIMIT 5;", nativeQuery = true)
    List<Recipe> findRandom5RecipesByThemeName(@Param("themeName") String themeName);

    @Query(value = "SELECT * FROM recipe ORDER BY RAND() limit 6", nativeQuery = true)
    List<Recipe> findRandomRecipes();

        @Query(value = "SELECT * FROM recipe r " +
                "JOIN tag t ON t.recipe_idx = r.recipe_idx " +
                "JOIN theme th ON t.theme_idx = th.theme_idx " +
                "WHERE th.theme_name = :themeName " +
                "ORDER BY r.recipe_idx DESC;", nativeQuery = true)
    List<Recipe> findByThemeName(@Param("themeName") String themeName);

}
