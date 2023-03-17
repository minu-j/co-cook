package com.cocook.service;

import com.cocook.auth.JwtTokenProvider;
import com.cocook.dto.home.CategoryResDto;
import com.cocook.dto.home.RandomResDto;
import com.cocook.dto.home.RecommendResDto;
import com.cocook.dto.home.ThemeResDto;
import com.cocook.dto.recipe.RecipeListResDto;
import com.cocook.entity.Category;
import com.cocook.entity.Favorite;
import com.cocook.entity.Recipe;
import com.cocook.entity.Theme;
import com.cocook.repository.CategoryRepository;
import com.cocook.repository.FavoriteRepository;
import com.cocook.repository.RecipeRepository;
import com.cocook.repository.ThemeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class HomeService {

    private final RecipeRepository recipeRepository;
    private final JwtTokenProvider jwtTokenProvider;
    private final FavoriteRepository favoriteRepository;
    private final ThemeRepository themeRepository;
    private final CategoryRepository categoryRepository;

    @Autowired
    public HomeService(RecipeRepository recipeRepository, JwtTokenProvider jwtTokenProvider, FavoriteRepository favoriteRepository, ThemeRepository themeRepository, CategoryRepository categoryRepository) {
        this.recipeRepository = recipeRepository;
        this.jwtTokenProvider = jwtTokenProvider;
        this.favoriteRepository = favoriteRepository;
        this.themeRepository = themeRepository;
        this.categoryRepository = categoryRepository;
    }

    public RecommendResDto getRecommendRecipes(String authToken) {
        String themeName;
        int currentHour = LocalDateTime.now().getHour();
        if (currentHour >= 4 && currentHour < 9) {
            themeName = "아침";
        } else if (currentHour >= 9 && currentHour < 15) {
            themeName = "점심";
        } else if (currentHour >= 15 && currentHour < 20) {
            themeName = "저녁";
        } else {
            themeName = "야식";
        }

        Long userIdx = jwtTokenProvider.getUserIdx(authToken);
        List<Recipe> foundRecipes = recipeRepository.findRandom5RecipesByThemeName(themeName);
        List<RecipeListResDto> resultRecipes = addRecipeToRecipeListResDto(foundRecipes, userIdx);

        return new RecommendResDto(resultRecipes);
    }

    public ThemeResDto getThemes() {
        List<Theme> themes = themeRepository.findAll();
        return new ThemeResDto(themes);
    }

    public CategoryResDto getCategories() {
        List<Category> categories = categoryRepository.findAll();
        return new CategoryResDto(categories);
    }

    public RandomResDto getRandomRecipes(String authToken) {
        Long userIdx = jwtTokenProvider.getUserIdx(authToken);
        List<Recipe> recipes = recipeRepository.findRandomRecipes();
        List<RecipeListResDto> recipeListResDtos = addRecipeToRecipeListResDto(recipes, userIdx);
        return new RandomResDto(recipeListResDtos);
    }

    private List<RecipeListResDto> addRecipeToRecipeListResDto(List<Recipe> orgRecipeList, Long userIdx) {
        List<RecipeListResDto> newRecipes = new ArrayList<>();
        for (Recipe recipe : orgRecipeList) {
            boolean isFavorite = getIsFavorite(userIdx, recipe.getId());
            RecipeListResDto recipeListResDto = RecipeListResDto.builder()
                    .recipeIdx(recipe.getId())
                    .recipeName(recipe.getRecipeName())
                    .recipeDifficulty(recipe.getDifficulty())
                    .recipeImgPath(recipe.getImgPath())
                    .recipeRunningTime(recipe.getRunningTime())
                    .isFavorite(isFavorite).build();
            newRecipes.add(recipeListResDto);
        }
        return newRecipes;
    }

    private boolean getIsFavorite(Long userIdx, Long recipeIdx) {
        boolean isFavorite;
        Favorite foundFavorite = favoriteRepository.findByUserIdAndRecipeId(userIdx, recipeIdx);
        if (foundFavorite != null) {
            isFavorite = true;
        } else {
            isFavorite = false;
        }
        return isFavorite;
    }

}