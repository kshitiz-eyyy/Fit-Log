package com.example.fitlog.ui

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.border
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
import androidx.compose.ui.graphics.painter.ColorPainter
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.fitlog.R

@Composable
fun FuelLogScreen(
    modifier: Modifier = Modifier
) {
    val backgroundColor = Color(0xFF000000)
    val cardBackgroundColor = Color(0xFF1C1C1E)
    val accentColor = Color(0xFFD0FD3E)
    val orangeColor = Color(0xFFFF5A1F)
    val cyanColor = Color(0xFF00E5FF)
    val textColor = Color.White
    val secondaryTextColor = Color(0xFF8E8E93)

    Scaffold(
        modifier = modifier.fillMaxSize(),
        containerColor = backgroundColor,
        topBar = {
            FuelTopBar()
        },
        bottomBar = {
            FuelBottomNavigationBar(accentColor = accentColor)
        },
        floatingActionButton = {
            FloatingActionButton(
                onClick = { },
                containerColor = accentColor,
                contentColor = Color.Black,
                shape = CircleShape,
                modifier = Modifier.size(56.dp)
            ) {
                Icon(
                    painter = painterResource(id = R.drawable.ic_cart_add),
                    contentDescription = null,
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
                .padding(horizontal = 24.dp)
        ) {
            Spacer(modifier = Modifier.height(16.dp))

            // Daily Energy Balance
            Text(
                text = stringResource(R.string.daily_energy_balance),
                color = textColor,
                fontSize = 12.sp,
                fontWeight = FontWeight.Bold,
                letterSpacing = 0.5.sp
            )

            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Row(verticalAlignment = Alignment.Bottom) {
                    Text(
                        text = "+420",
                        color = accentColor,
                        fontSize = 32.sp,
                        fontWeight = FontWeight.Black
                    )
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(
                        text = stringResource(R.string.kcal),
                        color = textColor,
                        fontSize = 18.sp,
                        fontWeight = FontWeight.Bold,
                        modifier = Modifier.padding(bottom = 4.dp)
                    )
                }

                Column(horizontalAlignment = Alignment.End) {
                    Text(
                        text = stringResource(R.string.surplus),
                        color = accentColor,
                        fontSize = 10.sp,
                        fontWeight = FontWeight.Black
                    )
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        Icon(
                            painter = painterResource(id = R.drawable.ic_chevron_up),
                            contentDescription = null,
                            tint = accentColor,
                            modifier = Modifier.size(12.dp)
                        )
                        Text(
                            text = "12%",
                            color = textColor,
                            fontSize = 12.sp,
                            fontWeight = FontWeight.Bold
                        )
                    }
                }
            }

            Spacer(modifier = Modifier.height(24.dp))

            // Burned / Intake Section
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                EnergyStatCard(
                    label = stringResource(R.string.burned),
                    value = "2,840",
                    progress = 0.85f,
                    progressColor = accentColor,
                    targetLabel = stringResource(R.string.of_target, "85%"),
                    goalLabel = stringResource(R.string.goal, "3,200"),
                    modifier = Modifier.weight(1f)
                )
                EnergyStatCard(
                    label = stringResource(R.string.intake),
                    value = "2,420",
                    valueColor = orangeColor,
                    progress = 0.72f,
                    progressColor = orangeColor,
                    targetLabel = stringResource(R.string.of_limit, "72%"),
                    goalLabel = stringResource(R.string.limit, "3,000"),
                    modifier = Modifier.weight(1f)
                )
            }

            Spacer(modifier = Modifier.height(40.dp))

            // Macronutrients
            Text(
                text = stringResource(R.string.macronutrients),
                color = textColor,
                fontSize = 18.sp,
                fontWeight = FontWeight.Black
            )

            Spacer(modifier = Modifier.height(16.dp))

            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                MacroCircleCard(
                    label = stringResource(R.string.protein),
                    amount = "160g",
                    target = "200g",
                    percentage = 0.80f,
                    color = accentColor,
                    modifier = Modifier.weight(1f),
                    cardBackgroundColor = cardBackgroundColor
                )
                MacroCircleCard(
                    label = stringResource(R.string.carbs),
                    amount = "220g",
                    target = "400g",
                    percentage = 0.55f,
                    color = textColor,
                    modifier = Modifier.weight(1f),
                    cardBackgroundColor = cardBackgroundColor
                )
                MacroCircleCard(
                    label = stringResource(R.string.fats),
                    amount = "54g",
                    target = "180g",
                    percentage = 0.30f,
                    color = cyanColor,
                    modifier = Modifier.weight(1f),
                    cardBackgroundColor = cardBackgroundColor
                )
            }

            Spacer(modifier = Modifier.height(40.dp))

            // Fuel Log Header
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = stringResource(R.string.fuel_log),
                    color = textColor,
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Black
                )
                Text(
                    text = "MAY 24, 2024",
                    color = secondaryTextColor,
                    fontSize = 10.sp,
                    fontWeight = FontWeight.Bold
                )
            }

            Spacer(modifier = Modifier.height(16.dp))

            // Fuel Log Items
            FuelLogItem(
                title = stringResource(R.string.breakfast),
                description = "Protein Oats & Berries",
                calories = "450",
                backgroundColor = cardBackgroundColor
            )
            Spacer(modifier = Modifier.height(12.dp))
            FuelLogItem(
                title = stringResource(R.string.lunch),
                description = "Grilled Chicken & Quinoa",
                calories = "720",
                backgroundColor = cardBackgroundColor
            )
            Spacer(modifier = Modifier.height(12.dp))
            
            // Empty State / Add Dinner
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .border(1.dp, accentColor, RoundedCornerShape(16.dp))
                    .clip(RoundedCornerShape(16.dp))
                    .background(cardBackgroundColor)
                    .padding(16.dp)
            ) {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Box(
                        modifier = Modifier
                            .size(48.dp)
                            .clip(RoundedCornerShape(12.dp))
                            .background(Color(0xFF2C2C2E)),
                        contentAlignment = Alignment.Center
                    ) {
                        Icon(
                            painter = painterResource(id = R.drawable.ic_fork_knife),
                            contentDescription = null,
                            tint = Color.Gray,
                            modifier = Modifier.size(24.dp)
                        )
                    }
                    Spacer(modifier = Modifier.width(16.dp))
                    Column(modifier = Modifier.weight(1f)) {
                        Text(
                            text = stringResource(R.string.dinner),
                            color = textColor,
                            fontSize = 16.sp,
                            fontWeight = FontWeight.Bold
                        )
                        Text(
                            text = stringResource(R.string.not_logged_yet),
                            color = secondaryTextColor,
                            fontSize = 12.sp,
                            fontStyle = androidx.compose.ui.text.font.FontStyle.Italic
                        )
                    }
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        Column(horizontalAlignment = Alignment.End) {
                            Text(text = "--", color = textColor, fontSize = 16.sp, fontWeight = FontWeight.Bold)
                            Text(text = "KCAL", color = secondaryTextColor, fontSize = 8.sp, fontWeight = FontWeight.Bold)
                        }
                        Spacer(modifier = Modifier.width(16.dp))
                        Box(
                            modifier = Modifier
                                .size(40.dp)
                                .clip(CircleShape)
                                .background(accentColor),
                            contentAlignment = Alignment.Center
                        ) {
                            Text("+", color = Color.Black, fontSize = 24.sp, fontWeight = FontWeight.Light)
                        }
                    }
                }
            }

            Spacer(modifier = Modifier.height(12.dp))
            FuelLogItem(
                title = stringResource(R.string.snacks),
                description = "Whey Isolate & Almonds",
                calories = "320",
                backgroundColor = cardBackgroundColor
            )

            Spacer(modifier = Modifier.height(100.dp))
        }
    }
}

@Composable
fun EnergyStatCard(
    label: String,
    value: String,
    valueColor: Color = Color.White,
    progress: Float,
    progressColor: Color,
    targetLabel: String,
    goalLabel: String,
    modifier: Modifier = Modifier
) {
    Column(modifier = modifier) {
        Text(text = label, color = Color(0xFF8E8E93), fontSize = 10.sp, fontWeight = FontWeight.Bold)
        Spacer(modifier = Modifier.height(4.dp))
        Text(text = value, color = valueColor, fontSize = 24.sp, fontWeight = FontWeight.Black)
        Spacer(modifier = Modifier.height(8.dp))
        
        // Progress Bar
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(4.dp)
                .clip(CircleShape)
                .background(Color(0xFF2C2C2E))
        ) {
            Box(
                modifier = Modifier
                    .fillMaxWidth(progress)
                    .fillMaxHeight()
                    .background(progressColor)
            )
        }
        
        Spacer(modifier = Modifier.height(8.dp))
        
        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
            Text(text = targetLabel, color = Color(0xFF8E8E93), fontSize = 9.sp, fontWeight = FontWeight.Medium)
            Text(text = goalLabel, color = Color(0xFF8E8E93), fontSize = 9.sp, fontWeight = FontWeight.Medium)
        }
    }
}

@Composable
fun MacroCircleCard(
    label: String,
    amount: String,
    target: String,
    percentage: Float,
    color: Color,
    modifier: Modifier = Modifier,
    cardBackgroundColor: Color
) {
    Column(
        modifier = modifier
            .clip(RoundedCornerShape(16.dp))
            .background(cardBackgroundColor)
            .padding(12.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Box(contentAlignment = Alignment.Center, modifier = Modifier.size(60.dp)) {
            Canvas(modifier = Modifier.size(50.dp)) {
                drawCircle(
                    color = Color(0xFF2C2C2E),
                    style = Stroke(width = 4.dp.toPx(), cap = StrokeCap.Round)
                )
                drawArc(
                    color = color,
                    startAngle = -90f,
                    sweepAngle = 360f * percentage,
                    useCenter = false,
                    style = Stroke(width = 4.dp.toPx(), cap = StrokeCap.Round)
                )
            }
            Text(
                text = "${(percentage * 100).toInt()}%",
                color = Color.White,
                fontSize = 10.sp,
                fontWeight = FontWeight.Bold
            )
        }
        Spacer(modifier = Modifier.height(8.dp))
        Text(text = label, color = Color(0xFF8E8E93), fontSize = 9.sp, fontWeight = FontWeight.Bold)
        Spacer(modifier = Modifier.height(4.dp))
        Text(text = amount, color = Color.White, fontSize = 14.sp, fontWeight = FontWeight.Black)
        Text(text = "of $target", color = Color(0xFF8E8E93), fontSize = 9.sp, fontWeight = FontWeight.Medium)
    }
}

@Composable
fun FuelLogItem(
    title: String,
    description: String,
    calories: String,
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
            Image(
                painter = ColorPainter(Color(0xFF3A3A3C)),
                contentDescription = null,
                modifier = Modifier.fillMaxSize()
            )
            Icon(
                painter = painterResource(id = R.drawable.ic_fork_knife),
                contentDescription = null,
                tint = Color.Gray.copy(alpha = 0.5f),
                modifier = Modifier.size(20.dp)
            )
        }
        Spacer(modifier = Modifier.width(16.dp))
        Column(modifier = Modifier.weight(1f)) {
            Text(text = title, color = Color.White, fontSize = 16.sp, fontWeight = FontWeight.Bold)
            Text(text = description, color = Color(0xFF8E8E93), fontSize = 12.sp)
        }
        Row(verticalAlignment = Alignment.CenterVertically) {
            Column(horizontalAlignment = Alignment.End) {
                Text(text = calories, color = Color(0xFFD0FD3E), fontSize = 16.sp, fontWeight = FontWeight.Bold)
                Text(text = "KCAL", color = Color(0xFF8E8E93), fontSize = 8.sp, fontWeight = FontWeight.Bold)
            }
            Spacer(modifier = Modifier.width(16.dp))
            Icon(
                painter = painterResource(id = R.drawable.ic_chevron_right),
                contentDescription = null,
                tint = Color(0xFF3A3A3C),
                modifier = Modifier.size(16.dp)
            )
        }
    }
}

@Composable
fun FuelTopBar() {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 24.dp, vertical = 16.dp),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Box(
            modifier = Modifier
                .size(36.dp)
                .clip(CircleShape)
                .border(1.dp, Color(0xFF333333), CircleShape)
                .background(Color(0xFF1C1C1E)),
            contentAlignment = Alignment.Center
        ) {
            Icon(
                painter = painterResource(id = R.drawable.ic_profile),
                contentDescription = null,
                tint = Color.Gray,
                modifier = Modifier.size(20.dp)
            )
        }

        Text(
            text = "FITLOG",
            color = Color.White,
            fontSize = 20.sp,
            fontWeight = FontWeight.Black,
            letterSpacing = 2.sp
        )

        Icon(
            painter = painterResource(id = R.drawable.ic_notification),
            contentDescription = null,
            tint = Color.White,
            modifier = Modifier.size(24.dp)
        )
    }
}

private data class FuelNavItem(val labelRes: Int, val iconRes: Int, val isSelected: Boolean)

@Composable
fun FuelBottomNavigationBar(accentColor: Color) {
    NavigationBar(
        containerColor = Color.Black,
        tonalElevation = 0.dp
    ) {
        val items = listOf(
            FuelNavItem(R.string.nav_dash, R.drawable.ic_nav_dash, false),
            FuelNavItem(R.string.nav_train, R.drawable.ic_nav_train, false),
            FuelNavItem(R.string.nav_fuel, R.drawable.ic_fork_knife, true),
            FuelNavItem(R.string.nav_goals, R.drawable.ic_history, false),
            FuelNavItem(R.string.nav_admin, R.drawable.ic_biometric, false)
        )

        items.forEach { item ->
            NavigationBarItem(
                icon = { 
                    if (item.isSelected) {
                        Box(
                            modifier = Modifier
                                .size(36.dp)
                                .clip(CircleShape)
                                .background(accentColor),
                            contentAlignment = Alignment.Center
                        ) {
                           Icon(
                               painterResource(item.iconRes), 
                               contentDescription = null, 
                               tint = Color.Black, 
                               modifier = Modifier.size(20.dp)
                           ) 
                        }
                    } else {
                        Icon(
                            painterResource(item.iconRes), 
                            contentDescription = null,
                            modifier = Modifier.size(24.dp)
                        )
                    }
                },
                label = { 
                    Text(
                        stringResource(item.labelRes), 
                        fontSize = 10.sp, 
                        fontWeight = if (item.isSelected) FontWeight.Bold else FontWeight.Medium
                    ) 
                },
                selected = item.isSelected,
                onClick = {},
                colors = NavigationBarItemDefaults.colors(
                    selectedIconColor = Color.Black,
                    selectedTextColor = accentColor,
                    unselectedIconColor = Color.White,
                    unselectedTextColor = Color.White,
                    indicatorColor = Color.Transparent
                )
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun FuelLogScreenPreview() {
    MaterialTheme {
        FuelLogScreen()
    }
}
