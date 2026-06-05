package com.example.fitlog.ui

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
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

private val DarkBackground = Color(0xFF000000)
private val CardBackground = Color(0xFF1C1C1E)
private val PrimaryOrange = Color(0xFFFF6D00)
private val CyanAccent = Color(0xFF00E5FF)
private val TextGray = Color(0xFF8E8E93)
private val DarkCyan = Color(0xFF003D4D)

@Composable
fun SleepScreen(
    modifier: Modifier = Modifier
) {
    Scaffold(
        modifier = modifier.fillMaxSize(),
        containerColor = DarkBackground,
        topBar = { SleepTopBar() },
        bottomBar = { SleepBottomBar() }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .padding(paddingValues)
                .fillMaxSize()
                .verticalScroll(rememberScrollState())
                .padding(horizontal = 20.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Spacer(modifier = Modifier.height(20.dp))
            
            SleepProgress(
                hours = "7.5",
                progress = 0.75f,
                modifier = Modifier.size(240.dp)
            )
            
            Spacer(modifier = Modifier.height(24.dp))
            
            QualityBadge()
            
            Spacer(modifier = Modifier.height(32.dp))
            
            Text(
                text = stringResource(R.string.sleep_history_title),
                color = Color.White,
                fontSize = 28.sp,
                fontWeight = FontWeight.Black,
                modifier = Modifier.fillMaxWidth(),
                textAlign = TextAlign.Start,
                fontStyle = androidx.compose.ui.text.font.FontStyle.Italic
            )
            
            Spacer(modifier = Modifier.height(16.dp))
            
            SleepHistoryChart(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(200.dp)
            )
            
            Spacer(modifier = Modifier.height(24.dp))
            
            TrackingSection(modifier = Modifier.fillMaxWidth())
            
            Spacer(modifier = Modifier.height(24.dp))
            
            LogSleepButton(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(60.dp)
            )
            
            Spacer(modifier = Modifier.height(32.dp))
        }
    }
}

@Composable
fun SleepTopBar() {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp, vertical = 12.dp),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        IconButton(onClick = { }) {
            Icon(
                painter = painterResource(id = R.drawable.ic_menu),
                contentDescription = "Menu",
                tint = Color.White,
                modifier = Modifier.size(24.dp)
            )
        }
        
        Text(
            text = "FIT LOG",
            color = Color.White,
            fontSize = 22.sp,
            fontWeight = FontWeight.ExtraBold,
            letterSpacing = 1.sp
        )
        
        IconButton(onClick = { }) {
            Icon(
                painter = painterResource(id = R.drawable.ic_notifications),
                contentDescription = "Notifications",
                tint = Color.White,
                modifier = Modifier.size(24.dp)
            )
        }
    }
}

@Composable
fun SleepProgress(
    hours: String,
    progress: Float,
    modifier: Modifier = Modifier
) {
    Box(
        modifier = modifier,
        contentAlignment = Alignment.Center
    ) {
        Canvas(modifier = Modifier.fillMaxSize()) {
            val strokeWidth = 14.dp.toPx()
            drawArc(
                color = Color.White.copy(alpha = 0.1f),
                startAngle = 0f,
                sweepAngle = 360f,
                useCenter = false,
                style = Stroke(width = strokeWidth)
            )
            drawArc(
                color = CyanAccent,
                startAngle = -90f,
                sweepAngle = progress * 360f,
                useCenter = false,
                style = Stroke(width = strokeWidth, cap = StrokeCap.Round)
            )
        }
        
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Text(
                text = stringResource(R.string.last_night_sleep),
                color = TextGray,
                fontSize = 14.sp,
                fontWeight = FontWeight.Bold
            )
            Text(
                text = hours,
                color = CyanAccent,
                fontSize = 64.sp,
                fontWeight = FontWeight.Bold
            )
            Text(
                text = stringResource(R.string.hours_label),
                color = Color.White,
                fontSize = 24.sp,
                fontWeight = FontWeight.Bold
            )
        }
    }
}

@Composable
fun QualityBadge() {
    Surface(
        color = Color(0xFF152A2D),
        shape = RoundedCornerShape(24.dp),
        border = androidx.compose.foundation.BorderStroke(1.dp, Color(0xFF1E3A3E))
    ) {
        Text(
            text = stringResource(R.string.quality_good_sleep),
            color = CyanAccent,
            fontSize = 13.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.padding(horizontal = 32.dp, vertical = 10.dp)
        )
    }
}

@Composable
fun SleepHistoryChart(modifier: Modifier = Modifier) {
    Surface(
        modifier = modifier,
        color = CardBackground,
        shape = RoundedCornerShape(12.dp)
    ) {
        Row(
            modifier = Modifier
                .fillMaxSize()
                .padding(20.dp),
            verticalAlignment = Alignment.Bottom,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            val data = listOf(0.4f, 0.5f, 0.45f, 0.35f, 0.65f, 0.15f, 0.85f, 0.3f)
            val days = listOf("M", "T", "W", "T", "V", "F", "S", "S")
            
            data.forEachIndexed { index, value ->
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.Bottom,
                    modifier = Modifier.fillMaxHeight()
                ) {
                    Box(
                        modifier = Modifier
                            .width(32.dp)
                            .fillMaxHeight(value)
                            .background(
                                color = if (value > 0.2f) Color(0xFF2E6B75) else Color(0xFF1A3B40),
                                shape = RoundedCornerShape(2.dp)
                            )
                    )
                    Spacer(modifier = Modifier.height(12.dp))
                    Text(
                        text = days[index],
                        color = TextGray,
                        fontSize = 12.sp,
                        fontWeight = FontWeight.Medium
                    )
                }
            }
        }
    }
}

@Composable
fun TrackingSection(modifier: Modifier = Modifier) {
    Surface(
        modifier = modifier,
        color = CardBackground,
        shape = RoundedCornerShape(12.dp),
        border = androidx.compose.foundation.BorderStroke(1.dp, Color(0xFF2E6B75).copy(alpha = 0.3f))
    ) {
        Column(modifier = Modifier.padding(20.dp)) {
            Text(
                text = stringResource(R.string.tonight_tracking_title),
                color = CyanAccent,
                fontSize = 14.sp,
                fontWeight = FontWeight.Bold
            )
            
            Spacer(modifier = Modifier.height(24.dp))
            
            TrackingRow(
                iconId = R.drawable.ic_sleep,
                title = stringResource(R.string.sleep_mode_label),
                subtitle = stringResource(R.string.sleep_mode_desc),
                checked = true
            )
            
            HorizontalDivider(color = Color.White.copy(alpha = 0.1f), modifier = Modifier.padding(vertical = 16.dp))
            
            TrackingRow(
                iconId = R.drawable.ic_alarm,
                title = stringResource(R.string.bedtime_alarm_label),
                subtitle = stringResource(R.string.bedtime_alarm_desc),
                checked = false
            )
        }
    }
}

@Composable
fun TrackingRow(
    iconId: Int,
    title: String,
    subtitle: String,
    checked: Boolean
) {
    var isChecked by remember { mutableStateOf(checked) }
    
    Row(
        modifier = Modifier.fillMaxWidth(),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Icon(
            painter = painterResource(id = iconId),
            contentDescription = null,
            tint = Color.White,
            modifier = Modifier.size(28.dp)
        )
        
        Spacer(modifier = Modifier.width(20.dp))
        
        Column(modifier = Modifier.weight(1f)) {
            Text(
                text = title,
                color = Color.White,
                fontSize = 17.sp,
                fontWeight = FontWeight.SemiBold
            )
            Text(
                text = subtitle,
                color = TextGray,
                fontSize = 13.sp
            )
        }
        
        Switch(
            checked = isChecked,
            onCheckedChange = { isChecked = it },
            colors = SwitchDefaults.colors(
                checkedThumbColor = Color.White,
                checkedTrackColor = CyanAccent,
                uncheckedThumbColor = Color.White,
                uncheckedTrackColor = Color.DarkGray,
                uncheckedBorderColor = Color.Transparent
            )
        )
    }
}

@Composable
fun LogSleepButton(modifier: Modifier = Modifier) {
    Button(
        onClick = { },
        modifier = modifier,
        colors = ButtonDefaults.buttonColors(containerColor = PrimaryOrange),
        shape = RoundedCornerShape(10.dp)
    ) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            Icon(
                painter = painterResource(id = R.drawable.ic_edit_calendar),
                contentDescription = null,
                tint = Color.Black,
                modifier = Modifier.size(24.dp)
            )
            Spacer(modifier = Modifier.width(12.dp))
            Text(
                text = stringResource(R.string.log_sleep_button),
                color = Color.Black,
                fontSize = 20.sp,
                fontWeight = FontWeight.ExtraBold
            )
        }
    }
}

@Composable
fun SleepBottomBar() {
    NavigationBar(
        containerColor = DarkBackground,
        tonalElevation = 0.dp
    ) {
        NavigationBarItem(
            selected = true,
            onClick = { },
            icon = { Icon(painterResource(id = R.drawable.ic_home), contentDescription = stringResource(R.string.nav_home), modifier = Modifier.size(24.dp)) },
            label = { Text(stringResource(R.string.nav_home), fontSize = 10.sp) },
            colors = NavigationBarItemDefaults.colors(
                selectedIconColor = Color.White,
                selectedTextColor = Color.White,
                unselectedIconColor = TextGray,
                unselectedTextColor = TextGray,
                indicatorColor = Color.Transparent
            )
        )
        NavigationBarItem(
            selected = false,
            onClick = { },
            icon = { Icon(painterResource(id = R.drawable.ic_bolt), contentDescription = stringResource(R.string.nav_features), modifier = Modifier.size(24.dp)) },
            label = { Text(stringResource(R.string.nav_features), fontSize = 10.sp) }
        )
        NavigationBarItem(
            selected = false,
            onClick = { },
            icon = { Icon(painterResource(id = R.drawable.ic_library), contentDescription = stringResource(R.string.nav_library), modifier = Modifier.size(24.dp)) },
            label = { Text(stringResource(R.string.nav_library), fontSize = 10.sp) }
        )
        NavigationBarItem(
            selected = false,
            onClick = { },
            icon = { Icon(painterResource(id = R.drawable.ic_running), contentDescription = stringResource(R.string.nav_activity), modifier = Modifier.size(24.dp)) },
            label = { Text(stringResource(R.string.nav_activity), fontSize = 10.sp) }
        )
        NavigationBarItem(
            selected = false,
            onClick = { },
            icon = { Icon(painterResource(id = R.drawable.ic_person), contentDescription = stringResource(R.string.nav_profile), modifier = Modifier.size(24.dp)) },
            label = { Text(stringResource(R.string.nav_profile), fontSize = 10.sp) }
        )
    }
}

@Preview(showBackground = true)
@Composable
fun SleepScreenPreview() {
    MaterialTheme {
        Surface(color = DarkBackground) {
            SleepScreen()
        }
    }
}
