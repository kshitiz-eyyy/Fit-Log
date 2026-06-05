package com.example.fitlog.ui

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.fitlog.R

private val DarkBackground = Color(0xFF121212)
private val SurfaceDark = Color(0xFF1E1E1E)
private val PrimaryOrange = Color(0xFFFF6D00)
private val SecondaryLime = Color(0xFFC6FF00)
private val CyanBlue = Color(0xFF00E5FF)
private val TextGray = Color(0xFFBDBDBD)

@Composable
fun WaterTrackerScreen(
    modifier: Modifier = Modifier,
    onBackClick: () -> Unit = {},
    onAddWaterClick: () -> Unit = {}
) {
    Scaffold(
        modifier = modifier.fillMaxSize(),
        containerColor = DarkBackground,
        topBar = {
            WaterTrackerTopBar()
        },
        bottomBar = {
            WaterTrackerBottomNav()
        }
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .verticalScroll(rememberScrollState())
                .padding(horizontal = 16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Spacer(modifier = Modifier.height(16.dp))
            
            // Screen Header
            Row(
                modifier = Modifier.fillMaxWidth(),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Icon(
                    painter = painterResource(id = R.drawable.ic_water_drop),
                    contentDescription = null,
                    tint = Color.White,
                    modifier = Modifier.size(24.dp)
                )
                Spacer(modifier = Modifier.width(12.dp))
                Text(
                    text = stringResource(id = R.string.water_tracker_title),
                    color = Color.White,
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold
                )
            }

            Spacer(modifier = Modifier.height(40.dp))

            // Circular Progress
            WaterProgressCircle(current = 2.4f, goal = 3.5f)

            Spacer(modifier = Modifier.height(20.dp))

            Text(
                text = stringResource(id = R.string.water_goal_format, "3.5"),
                color = TextGray,
                fontSize = 14.sp,
                fontWeight = FontWeight.Bold,
                letterSpacing = 1.sp
            )

            Spacer(modifier = Modifier.height(40.dp))

            // Quick Add Buttons
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                QuickAddButton(
                    modifier = Modifier.weight(1f),
                    label = stringResource(id = R.string.plus_1_cup),
                    iconResId = R.drawable.ic_cup
                )
                QuickAddButton(
                    modifier = Modifier.weight(1f),
                    label = stringResource(id = R.string.plus_500ml),
                    iconResId = R.drawable.ic_water_bottle
                )
                QuickAddButton(
                    modifier = Modifier.weight(1f),
                    label = stringResource(id = R.string.minus_250ml),
                    iconResId = R.drawable.ic_refresh // Using refresh as an 'undo' icon
                )
            }

            Spacer(modifier = Modifier.height(32.dp))

            // Reminder Settings Card
            ReminderSettingsCard()

            Spacer(modifier = Modifier.height(32.dp))

            // Hydration Log Section
            HydrationLogSection()
            
            Spacer(modifier = Modifier.height(32.dp))

            // Add Water Button
            Button(
                onClick = onAddWaterClick,
                modifier = Modifier
                    .fillMaxWidth()
                    .height(56.dp),
                colors = ButtonDefaults.buttonColors(
                    containerColor = PrimaryOrange
                ),
                shape = RoundedCornerShape(28.dp)
            ) {
                Text(
                    text = stringResource(id = R.string.add_water_btn),
                    color = Color.Black,
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Bold
                )
            }
            
            Spacer(modifier = Modifier.height(32.dp))
        }
    }
}

@Composable
fun WaterTrackerTopBar() {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .background(DarkBackground)
            .padding(horizontal = 16.dp, vertical = 12.dp),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Icon(
            painter = painterResource(id = R.drawable.ic_menu),
            contentDescription = "Menu",
            tint = Color.White,
            modifier = Modifier.size(24.dp).clickable { }
        )

        Text(
            text = stringResource(id = R.string.fit_log_display),
            color = Color.White,
            fontSize = 20.sp,
            fontWeight = FontWeight.Black,
            letterSpacing = 2.sp
        )

        Icon(
            painter = painterResource(id = R.drawable.ic_notifications),
            contentDescription = "Notifications",
            tint = Color.White,
            modifier = Modifier.size(24.dp).clickable { }
        )
    }
}

@Composable
fun WaterProgressCircle(current: Float, goal: Float) {
    val progress = current / goal
    Box(
        contentAlignment = Alignment.Center,
        modifier = Modifier.size(220.dp)
    ) {
        androidx.compose.foundation.Canvas(modifier = Modifier.fillMaxSize()) {
            val strokeWidth = 14.dp.toPx()
            // Background circle
            drawArc(
                color = Color.DarkGray.copy(alpha = 0.2f),
                startAngle = 0f,
                sweepAngle = 360f,
                useCenter = false,
                style = Stroke(width = strokeWidth, cap = StrokeCap.Round)
            )
            // Progress arc
            drawArc(
                brush = Brush.sweepGradient(
                    0.0f to SecondaryLime,
                    0.5f to CyanBlue,
                    1.0f to SecondaryLime
                ),
                startAngle = -90f,
                sweepAngle = 360f * progress,
                useCenter = false,
                style = Stroke(width = strokeWidth, cap = StrokeCap.Round)
            )
        }
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Text(
                text = current.toString(),
                color = SecondaryLime,
                fontSize = 56.sp,
                fontWeight = FontWeight.Black
            )
            Text(
                text = stringResource(id = R.string.liters_label),
                color = TextGray,
                fontSize = 16.sp,
                fontWeight = FontWeight.Bold,
                letterSpacing = 1.sp
            )
        }
    }
}

@Composable
fun QuickAddButton(
    modifier: Modifier = Modifier,
    label: String,
    iconResId: Int
) {
    Surface(
        modifier = modifier.height(100.dp),
        color = SurfaceDark,
        shape = RoundedCornerShape(16.dp)
    ) {
        Column(
            modifier = Modifier.fillMaxSize(),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Icon(
                painter = painterResource(id = iconResId),
                contentDescription = null,
                tint = CyanBlue,
                modifier = Modifier.size(32.dp)
            )
            Spacer(modifier = Modifier.height(12.dp))
            Text(
                text = label,
                color = Color.White,
                fontSize = 14.sp,
                fontWeight = FontWeight.Bold
            )
        }
    }
}

@Composable
fun ReminderSettingsCard() {
    Surface(
        modifier = Modifier.fillMaxWidth(),
        color = SurfaceDark,
        shape = RoundedCornerShape(20.dp),
        border = androidx.compose.foundation.BorderStroke(1.dp, CyanBlue.copy(alpha = 0.3f))
    ) {
        Column(
            modifier = Modifier.padding(20.dp)
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Icon(
                        painter = painterResource(id = R.drawable.ic_alarm),
                        contentDescription = null,
                        tint = SecondaryLime,
                        modifier = Modifier.size(24.dp)
                    )
                    Spacer(modifier = Modifier.width(12.dp))
                    Text(
                        text = stringResource(id = R.string.reminder_settings_label),
                        color = Color.White,
                        fontSize = 16.sp,
                        fontWeight = FontWeight.Bold
                    )
                }
                var checked by remember { mutableStateOf(true) }
                Switch(
                    checked = checked,
                    onCheckedChange = { checked = it },
                    colors = SwitchDefaults.colors(
                        checkedThumbColor = Color.White,
                        checkedTrackColor = SecondaryLime,
                        uncheckedTrackColor = Color.DarkGray
                    )
                )
            }
            
            Spacer(modifier = Modifier.height(20.dp))
            
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = stringResource(id = R.string.frequency_label),
                    color = TextGray,
                    fontSize = 16.sp
                )
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Text(
                        text = stringResource(id = R.string.every_1h),
                        color = SecondaryLime,
                        fontSize = 16.sp,
                        fontWeight = FontWeight.Bold
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Icon(
                        painter = painterResource(id = R.drawable.ic_arrow_down),
                        contentDescription = null,
                        tint = TextGray,
                        modifier = Modifier.size(20.dp)
                    )
                }
            }
        }
    }
}

@Composable
fun HydrationLogSection() {
    Column(modifier = Modifier.fillMaxWidth()) {
        Text(
            text = stringResource(id = R.string.hydration_log_label),
            color = TextGray,
            fontSize = 14.sp,
            fontWeight = FontWeight.Bold,
            letterSpacing = 1.sp
        )
        
        Spacer(modifier = Modifier.height(20.dp))
        
        LogItem(
            title = stringResource(id = R.string.bottled_water_label),
            time = stringResource(id = R.string.time_8_45_am),
            amount = stringResource(id = R.string.vol_500ml),
            accentColor = SecondaryLime
        )
        Spacer(modifier = Modifier.height(16.dp))
        LogItem(
            title = stringResource(id = R.string.glass_of_water_label),
            time = stringResource(id = R.string.time_10_15_am),
            amount = stringResource(id = R.string.vol_250ml),
            accentColor = CyanBlue
        )
        Spacer(modifier = Modifier.height(16.dp))
        LogItem(
            title = stringResource(id = R.string.protein_shake_label),
            time = stringResource(id = R.string.time_12_30_pm),
            amount = stringResource(id = R.string.vol_400ml),
            accentColor = SecondaryLime
        )
    }
}

@Composable
fun LogItem(
    title: String,
    time: String,
    amount: String,
    accentColor: Color
) {
    Surface(
        modifier = Modifier.fillMaxWidth(),
        color = SurfaceDark,
        shape = RoundedCornerShape(16.dp)
    ) {
        Row(
            modifier = Modifier.height(IntrinsicSize.Min),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Box(
                modifier = Modifier
                    .width(4.dp)
                    .fillMaxHeight()
                    .background(accentColor)
            )
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Box(
                        modifier = Modifier
                            .size(32.dp)
                            .clip(CircleShape)
                            .background(accentColor.copy(alpha = 0.1f))
                            .border(1.dp, accentColor, CircleShape),
                        contentAlignment = Alignment.Center
                    ) {
                        Icon(
                            painter = painterResource(id = R.drawable.ic_check_simple),
                            contentDescription = null,
                            tint = accentColor,
                            modifier = Modifier.size(18.dp)
                        )
                    }
                    Spacer(modifier = Modifier.width(16.dp))
                    Column {
                        Text(
                            text = title,
                            color = Color.White,
                            fontSize = 16.sp,
                            fontWeight = FontWeight.Bold
                        )
                        Text(
                            text = time,
                            color = TextGray,
                            fontSize = 14.sp
                        )
                    }
                }
                Text(
                    text = amount,
                    color = accentColor,
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Black
                )
            }
        }
    }
}

@Composable
fun WaterTrackerBottomNav() {
    NavigationBar(
        containerColor = DarkBackground,
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
                        painter = painterResource(id = iconRes), 
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
                    selectedIconColor = SecondaryLime,
                    selectedTextColor = SecondaryLime,
                    unselectedIconColor = Color(0xFF48484A),
                    unselectedTextColor = Color(0xFF48484A),
                    indicatorColor = Color.Transparent
                )
            )
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFF121212)
@Composable
fun WaterTrackerScreenPreview() {
    MaterialTheme {
        Surface(color = DarkBackground) {
            WaterTrackerScreen()
        }
    }
}
