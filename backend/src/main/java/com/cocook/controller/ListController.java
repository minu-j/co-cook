package com.cocook.controller;

import com.cocook.dto.ApiResponse;
import com.cocook.dto.list.RecipeListResDto;
import com.cocook.service.ListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/list")
public class ListController {

    private final ListService listService;

    @Autowired
    public ListController(ListService listService) {
        this.listService = listService;
    }

    @GetMapping("/theme")
    public ResponseEntity<ApiResponse<RecipeListResDto>> getRecipesByThemeName(@RequestHeader("AUTH-TOKEN") String authToken,
                                                                               @RequestParam String themeName,
                                                                               @RequestParam String difficulty,
                                                                               @RequestParam Integer time) {
        RecipeListResDto recipeListResDto = listService.getRecipesByThemeName(authToken, themeName, difficulty, time);
        return ApiResponse.ok(recipeListResDto);
    }

    @GetMapping("/category")
    public ResponseEntity<ApiResponse<RecipeListResDto>> getRecipesByCategoryName(@RequestHeader("AUTH-TOKEN") String authToken,
                                                                               @RequestParam String categoryName,
                                                                               @RequestParam String difficulty,
                                                                               @RequestParam Integer time) {
        RecipeListResDto recipeListResDto = listService.getRecipesByCategoryName(authToken, categoryName, difficulty, time);
        return ApiResponse.ok(recipeListResDto);
    }

    @GetMapping("/all")
    public ResponseEntity<ApiResponse<RecipeListResDto>> getAllRecipes(@RequestHeader("AUTH-TOKEN") String authToken,
                                                                                  @RequestParam String difficulty,
                                                                                  @RequestParam Integer time) {
        RecipeListResDto recipeListResDto = listService.getAllRecipes(authToken, difficulty, time);
        return ApiResponse.ok(recipeListResDto);
    }


}
