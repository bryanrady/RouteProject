package com.bryanrady.module_base;

import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.Unbinder;

/**
 * @author: wangqingbin
 * @date: 2020/4/14 16:55
 */
public abstract class BaseActivity extends AppCompatActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);

        View view = LayoutInflater.from(this).inflate(bindLayout(), null, false);
        setContentView(view);
        ButterKnife.bind(view);

    }

    protected abstract int bindLayout();



    @Override
    protected void onDestroy() {
        super.onDestroy();
    }
}
