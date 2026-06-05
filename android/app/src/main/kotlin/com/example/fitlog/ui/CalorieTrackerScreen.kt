package com.example.fitlog.ui

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.fitlog.R

@Composable
fun CalorieTrackerScreen(
    modifier: Modifier = Modifier,
    onLogMealClick: () -> Unit = {},
    onAddClick: () -> Unit = {}
) {
    val backgroundColor = Color(0xFF000000)
    val cardBackgroundColor = Color(0xFF1C1C1E)
    val accentColor = Color(0xFFD0FD3E)
    val macroBarColor = Color(0xFF00B2E2)
    val orangeColor = Color(0xFFFF5A1F)

    Scaffold(
        modifier = modifier.fillMaxSize(),
        containerColor = backgroundColor,
        topBar = {
            CalorieTrackerTopBar()
        },
        bottomBar = {
            CalorieTrackerBottomNavigationBar()
        },
        floatingActionButton = {
            FloatingActionButton(
                onClick = onAddClick,
                containerColor = accentColor,
                contentColor = Color.Black,
                shape = CircleShape,
                modifier = Modifier.size(56.dp)
            ) {
                Icon(
                    painter = painterResource(id = R.drawable.ic_add),
                    contentDescription = "Add",
                    modifier = Modifier.size(24.dp)
                )
            }
        }
    ) { innerPadding ->
        Column(
            modifier = Modifier
                .padding(innerPadding)
                .fillMaxSize()
                .verticalScroll(rememberScrollState())
                .padding(horizontal = 24.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Spacer(modifier = Modifier.height(24.dp))

            // Calorie Ring
            CalorieRing(
                current = 1850,
                goal = 2000,
                accentColor = accentColor,
                modifier = Modifier.size(220.dp)
            )

            Spacer(modifier = Modifier.height(32.dp))

            // Macros Card
            MacrosCard(
                protein = 142 to 180,
                carbs = 210 to 250,
                fats = 45 to 65,
                backgroundColor = cardBackgroundColor,
                barColor = macroBarColor
            )

            Spacer(modifier = Modifier.height(32.dp))

            // Meals Section
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = stringResource(R.string.meals_today_title),
                    color = Color.White,
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Black
                )
                Text(
                    text = stringResource(R.string.entries_count, 3),
                    color = Color(0xFF8E8E93),
                    fontSize = 11.sp,
                    fontWeight = FontWeight.Bold
                )
            }

            Spacer(modifier = Modifier.height(16.dp))

            MealItem(
                name = stringResource(R.string.breakfast),
                calories = 450,
                backgroundColor = cardBackgroundColor
            )

            Spacer(modifier = Modifier.height(12.dp))

            MealItem(
                name = stringResource(R.string.lunch),
                calories = 620,
                backgroundColor = cardBackgroundColor
            )

            Spacer(modifier = Modifier.height(12.dp))

            MealItem(
                name = stringResource(R.string.snack),
                calories = 150,
                backgroundColor = cardBackgroundColor
            )

            Spacer(modifier = Modifier.height(32.dp))

            // Log Meal Button
            Button(
                onClick = onLogMealClick,
                modifier = Modifier
                    .fillMaxWidth()
                    .height(56.dp),
                shape = RoundedCornerShape(12.dp),
                colors = ButtonDefaults.buttonColors(containerColor = orangeColor)
            ) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Icon(
                        painter = painterResource(id = R.drawable.ic_add),
                        contentDescription = null,
                        modifier = Modifier.size(20.dp)
                    )
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(
                        text = stringResource(R.string.log_meal_btn),
                        fontSize = 14.sp,
                        fontWeight = FontWeight.Bold,
                        letterSpacing = 1.sp
                    )
                }
            }

            Spacer(modifier = Modifier.height(32.dp))
        }
    }
}

@Composable
fun CalorieTrackerTopBar() {
    Column(modifier = Modifier.background(Color.Black)) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 24.dp, vertical = 12.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Icon(
                painter = painterResource(id = R.drawable.ic_nav_dash),
                contentDescription = null,
                tint = Color.White,
                modifier = Modifier.size(20.dp)
            )
            Spacer(modifier = Modifier.width(8.dp))
            Text(
                text = stringResource(R.string.calorie_tracker_title),
                color = Color.White,
                fontSize = 18.sp,
                fontWeight = FontWeight.Medium
            )
        }

        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 24.dp, vertical = 8.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Icon(
                painter = painterResource(id = R.drawable.ic_menu),
                contentDescription = "Menu",
                tint = Color.White,
                modifier = Modifier.size(24.dp)
            )

            Text(
                text = stringResource(R.string.fit_log_display),
                color = Color.White,
                fontSize = 20.sp,
                fontWeight = FontWeight.Black,
                letterSpacing = 2.sp
            )

            Icon(
                painter = painterResource(id = R.drawable.ic_notification),
                contentDescription = "Notifications",
                tint = Color.White,
                modifier = Modifier.size(24.dp)
            )
        }
    }
}

@Composable
fun CalorieRing(
    current: Int,
    goal: Int,
    accentColor: Color,
    modifier: Modifier = Modifier
) {
    Box(modifier = modifier, contentAlignment = Alignment.Center) {
        Canvas(modifier = Modifier.fillMaxSize()) {
            val strokeWidth = 12.dp.toPx()
            drawArc(
                color = Color(0xFF333333),
                startAngle = 0f,
                sweepAngle = 360f,
                useCenter = false,
                style = Stroke(width = strokeWidth, cap = StrokeCap.Round)
            )
            drawArc(
                color = accentColor,
                startAngle = -90f,
                sweepAngle = (current.toFloat() / goal.toFloat()) * 360f,
                useCenter = false,
                style = Stroke(width = strokeWidth, cap = StrokeCap.Round)
            )
        }
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Text(
                text = current.toString(),
                color = Color.White,
                fontSize = 48.sp,
                fontWeight = FontWeight.Black
            )
            Text(
                text = "/ $goal ${stringResource(R.string.kcal_uppercase)}",
                color = Color(0xFF8E8E93),
                fontSize = 14.sp,
                fontWeight = FontWeight.Bold
            )
            Text(
                text = stringResource(R.string.todays_total),
                color = accentColor,
                fontSize = 11.sp,
                fontWeight = FontWeight.Bold,
                modifier = Modifier.padding(top = 4.dp)
            )
        }
    }
}

@Composable
fun MacrosCard(
    protein: Pair<Int, Int>,
    carbs: Pair<Int, Int>,
    fats: Pair<Int, Int>,
    backgroundColor: Color,
    barColor: Color
) {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(16.dp))
            .background(backgroundColor)
            .padding(20.dp)
    ) {
        Text(
            text = stringResource(R.string.macros_title),
            color = Color.White,
            fontSize = 18.sp,
            fontWeight = FontWeight.Black
        )
        
        Spacer(modifier = Modifier.height(20.dp))
        
        MacroRow(label = stringResource(R.string.protein), current = protein.first, goal = protein.second, barColor = barColor)
        Spacer(modifier = Modifier.height(16.dp))
        MacroRow(label = stringResource(R.string.carbs), current = carbs.first, goal = carbs.second, barColor = barColor)
        Spacer(modifier = Modifier.height(16.dp))
        MacroRow(label = stringResource(R.string.fats), current = fats.first, goal = fats.second, barColor = Color(0xFF48484A))
    }
}

@Composable
fun MacroRow(label: String, current: Int, goal: Int, barColor: Color) {
    Column {
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Text(text = label.uppercase(), color = Color.White, fontSize = 11.sp, fontWeight = FontWeight.Bold)
            Row {
                Text(text = "${current}G", color = barColor, fontSize = 11.sp, fontWeight = FontWeight.Bold)
                Text(text = " / ${goal}G", color = Color(0xFF8E8E93), fontSize = 11.sp, fontWeight = FontWeight.Bold)
            }
        }
        Spacer(modifier = Modifier.height(8.dp))
        LinearProgressIndicator(
            progress = current.toFloat() / goal.toFloat(),
            modifier = Modifier
                .fillMaxWidth()
                .height(6.dp)
                .clip(RoundedCornerShape(3.dp)),
            color = barColor,
            trackColor = Color(0xFF333333)
        )
    }
}

@Composable
fun MealItem(
    name: String,
    calories: Int,
    backgroundColor: Color
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(16.dp))
            .background(backgroundColor)
            .padding(16.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Box(
            modifier = Modifier
                .size(48.dp)
                .clip(RoundedCornerShape(12.dp))
                .background(Color(0xFF2C2C2E)),
            contentAlignment = Alignment.Center
        ) {
            // Placeholder for food image
            Icon(
                painter = painterResource(id = R.drawable.ic_fork_knife),
                contentDescription = null,
                tint = Color.Gray,
                modifier = Modifier.size(24.dp)
            )
        }
        Spacer(modifier = Modifier.width(16.dp))
        Column {
            Text(text = name, color = Color.White, fontSize = 14.sp, fontWeight = FontWeight.Bold)
            Text(text = "$calories ${stringResource(R.string.kcal)}", color = Color(0xFF8E8E93), fontSize = 12.sp)
        }
    }
}

@Composable
fun CalorieTrackerBottomNavigationBar() {
    NavigationBar(
        containerColor = Color.Black,
        tonalElevation = 0.dp
    ) {
        val items = listOf(
            Triple(stringResource(R.string.nav_home), R.drawable.ic_home, true),
            Triple(stringResource(R.string.nav_features), R.drawable.ic_bolt, false),
            Triple(stringResource(R.string.nav_library), R.drawable.ic_library, false),
            Triple(stringResource(R.string.nav_activity), R.drawable.ic_running, false),
            Triple(stringResource(R.string.nav_profile), R.drawable.ic_profile, false)
        )

        items.forEach { (label, iconRes, isSelected) ->
            NavigationBarItem(
                icon = { 
                    Icon(
                        painterResource(iconRes), 
                        contentDescription = null,
                        modifier = Modifier.size(24.dp)
                    )
                },
                label = { 
                    Text(
                        label, 
                        fontSize = 10.sp, 
                        fontWeight = if (isSelected) FontWeight.Bold else FontWeight.Medium
                    ) 
                },
                selected = isSelected,
                onClick = {},
                colors = NavigationBarItemDefaults.colors(
                    selectedIconColor = Color.White,
                    selectedTextColor = Color.White,
                    unselectedIconColor = Color(0xFF48484A),
                    unselectedTextColor = Color(0xFF48484A),
                    indicatorColor = Color.Transparent
                )
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun CalorieTrackerScreenPreview() {
    MaterialTheme {
        CalorieTrackerScreen()
    }
}
