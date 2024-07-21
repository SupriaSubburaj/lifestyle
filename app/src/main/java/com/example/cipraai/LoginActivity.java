package com.example.cipraai;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import java.io.IOException;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class LoginActivity extends AppCompatActivity {

    private static final String TAG = "LoginActivity";
    private static final String BASE_URL = "https://api.cipra.ai:5000/";

    private EditText emailEditText;
    private EditText passwordEditText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        emailEditText = findViewById(R.id.email);
        passwordEditText = findViewById(R.id.password);
        Button loginButton = findViewById(R.id.login_button);

        loginButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String email = emailEditText.getText().toString();
                String password = passwordEditText.getText().toString();

                // Input validation
                if (email.isEmpty()) {
                    Log.d(TAG, "Email field is empty");
                    Toast.makeText(LoginActivity.this, "Please enter your email", Toast.LENGTH_SHORT).show();
                    return;
                }

                if (password.isEmpty()) {
                    Log.d(TAG, "Password field is empty");
                    Toast.makeText(LoginActivity.this, "Please enter your password", Toast.LENGTH_SHORT).show();
                    return;
                }


                // Create Retrofit instance
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(BASE_URL)
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();


                // Create ApiService instance
                ApiService apiService = retrofit.create(ApiService.class);

                // Make API call
                Call<ApiResponse> call = apiService.login(email, password);
                Log.d(TAG, "Request email: " + email + ", password: " + password);

                call.enqueue(new Callback<ApiResponse>() {
                    @Override
                    public void onResponse(@NonNull Call<ApiResponse> call, @NonNull Response<ApiResponse> response) {
//                        // Log response details
                        Log.d(TAG, "Response code: " + response.code());
//                        Log.d(TAG, "Response message: " + response.message());
//
//                        if (response.body() != null) {
//                            try {
////                                Log.d(TAG, "Response body: " + response.body().toString());
//                            } catch (Exception e) {
//                                Log.e(TAG, "Error reading response body", e);
//                            }
//                        } else {
//                            try {
//                                Log.d(TAG, "Error body: " + (response.errorBody() != null ? response.errorBody().string() : "No error body"));
//                            } catch (IOException e) {
//                                Log.e(TAG, "Error reading error body", e);
//                            }
//                        }

                        // Handle response
                        if (response.isSuccessful()) {
                            Log.d(TAG, "Successful login");
                            ApiResponse apiResponse = response.body();
                            if (apiResponse != null && apiResponse.isSuccess()) {
                                Toast.makeText(LoginActivity.this, "Successful login", Toast.LENGTH_SHORT).show();
                                Intent intent = new Intent(LoginActivity.this, MainActivity.class);
                                startActivity(intent);
                                finish();
                            } else {
                                Toast.makeText(LoginActivity.this, "Invalid email or password", Toast.LENGTH_SHORT).show();
                            }
                        } else {
                            Toast.makeText(LoginActivity.this, "Login failed: " + response.message(), Toast.LENGTH_SHORT).show();
                        }
                    }

                    @Override
                    public void onFailure(@NonNull Call<ApiResponse> call, @NonNull Throwable t) {
                        Log.e(TAG, "Network error: " + t.getMessage(), t);
                        Toast.makeText(LoginActivity.this, "Network error: " + t.getMessage(), Toast.LENGTH_SHORT).show();
                    }
                });
            }
        });
    }
}
