package com.example.cipraai;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Query;

public interface ApiService {
    @GET("takehome/signin")
    Call<ApiResponse> login(
            @Query("email") String email,
            @Query("password") String password
    );
}
