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
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.fitlog.R

@Composable
fun TerminateAccountScreen(
    modifier: Modifier = Modifier,
    onBackClick: () -> Unit = {},
    onEditAllClick: () -> Unit = {},
    onUpdatePasswordClick: () -> Unit = {},
    onDataExportClick: () -> Unit = {},
    onDeleteAccountClick: () -> Unit = {}
) {
    val backgroundColor = Color(0xFF000000)
    val cardBackgroundColor = Color(0xFF1C1C1E)
    val accentColor = Color(0xFFD0FD3E)
    val warningColor = Color(0xFFFF5A1F)
    val textColor = Color.White
    val secondaryTextColor = Color(0xFF8E8E93)

    Scaffold(
        modifier = modifier.fillMaxSize(),
        containerColor = backgroundColor,
        topBar = {
            Column {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = 24.dp, vertical = 8.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Icon(
                        painter = painterResource(id = R.drawable.ic_nav_dash),
                        contentDescription = null,
                        tint = secondaryTextColor,
                        modifier = Modifier.size(16.dp)
                    )
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(
                        text = "delete account",
                        color = secondaryTextColor,
                        fontSize = 14.sp,
                        fontWeight = FontWeight.Medium
                    )
                }
                
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = 24.dp, vertical = 16.dp),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Box(
                        modifier = Modifier
                            .size(40.dp)
                            .clip(CircleShape)
                            .border(1.dp, Color(0xFF333333), CircleShape)
                            .background(Color(0xFF1C1C1E)),
                        contentAlignment = Alignment.Center
                    ) {
                        Icon(
                            painter = painterResource(id = R.drawable.ic_profile),
                            contentDescription = null,
                            tint = Color.Gray,
                            modifier = Modifier.size(24.dp)
                        )
                    }

                    Text(
                        text = "FITLOG",
                        color = textColor,
                        fontSize = 22.sp,
                        fontWeight = FontWeight.Black,
                        letterSpacing = 2.sp
                    )

                    Icon(
                        painter = painterResource(id = R.drawable.ic_notification),
                        contentDescription = null,
                        tint = textColor,
                        modifier = Modifier.size(24.dp)
                    )
                }
            }
        },
        bottomBar = {
            TerminateAccountBottomNav(accentColor = accentColor)
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

            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.Bottom
            ) {
                Column {
                    Text(
                        text = "ATHLETE PROFILE",
                        color = accentColor,
                        fontSize = 11.sp,
                        fontWeight = FontWeight.Bold,
                        letterSpacing = 0.5.sp
                    )
                    Text(
                        text = "ACCOUNT",
                        color = textColor,
                        fontSize = 32.sp,
                        fontWeight = FontWeight.Black
                    )
                }
                Column(horizontalAlignment = Alignment.End) {
                    Text(
                        text = "Member Since",
                        color = textColor,
                        fontSize = 10.sp,
                        fontWeight = FontWeight.Bold
                    )
                    Text(
                        text = "MAR 2023",
                        color = textColor,
                        fontSize = 18.sp,
                        fontWeight = FontWeight.Black
                    )
                }
            }

            Spacer(modifier = Modifier.height(32.dp))

            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = "PERSONAL DETAILS",
                    color = textColor,
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Black
                )
                Text(
                    text = "EDIT ALL",
                    color = accentColor,
                    fontSize = 11.sp,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.clickable { onEditAllClick() }
                )
            }

            Spacer(modifier = Modifier.height(16.dp))

            TerminateDetailCard(
                label = "FULL NAME",
                value = "Alex Sterling",
                backgroundColor = cardBackgroundColor
            )

            Spacer(modifier = Modifier.height(12.dp))

            TerminateDetailCard(
                label = "EMAIL ADDRESS",
                value = "a.sterling.performance@forge.com",
                backgroundColor = cardBackgroundColor
            )

            Spacer(modifier = Modifier.height(12.dp))

            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                TerminateStatCard(
                    label = "HEIGHT",
                    value = "188",
                    unit = "cm",
                    modifier = Modifier.weight(1f),
                    backgroundColor = cardBackgroundColor
                )
                TerminateStatCard(
                    label = "WEIGHT",
                    value = "92.4",
                    unit = "kg",
                    modifier = Modifier.weight(1f),
                    backgroundColor = cardBackgroundColor
                )
                TerminateStatCard(
                    label = "BODY FAT",
                    value = "10.2",
                    unit = "%",
                    modifier = Modifier.weight(1f),
                    backgroundColor = cardBackgroundColor
                )
            }

            Spacer(modifier = Modifier.height(40.dp))

            Text(
                text = "SECURITY & PRIVACY",
                color = textColor,
                fontSize = 18.sp,
                fontWeight = FontWeight.Black
            )

            Spacer(modifier = Modifier.height(16.dp))

            TerminateOptionItem(
                iconRes = R.drawable.ic_lock,
                title = "Update Password",
                onClick = onUpdatePasswordClick,
                backgroundColor = cardBackgroundColor
            )

            Spacer(modifier = Modifier.height(12.dp))

            var biometricEnabled by remember { mutableStateOf(true) }
            TerminateOptionItem(
                iconRes = R.drawable.ic_biometric,
                title = "Biometric Authentication",
                backgroundColor = cardBackgroundColor,
                trailing = {
                    Switch(
                        checked = biometricEnabled,
                        onCheckedChange = { biometricEnabled = it },
                        colors = SwitchDefaults.colors(
                            checkedThumbColor = Color.Black,
                            checkedTrackColor = accentColor,
                            uncheckedThumbColor = Color.White,
                            uncheckedTrackColor = Color(0xFF3A3A3C),
                            uncheckedBorderColor = Color.Transparent
                        )
                    )
                }
            )

            Spacer(modifier = Modifier.height(12.dp))

            TerminateOptionItem(
                iconRes = R.drawable.ic_history,
                title = "Data Export History",
                onClick = onDataExportClick,
                backgroundColor = cardBackgroundColor
            )

            Spacer(modifier = Modifier.height(40.dp))

            TerminateSection(
                onDeleteClick = onDeleteAccountClick,
                warningColor = warningColor,
                backgroundColor = Color(0xFF1A1210)
            )

            Spacer(modifier = Modifier.height(40.dp))
        }
    }
}

@Composable
fun TerminateDetailCard(
    label: String,
    value: String,
    backgroundColor: Color
) {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(16.dp))
            .background(backgroundColor)
            .padding(16.dp)
    ) {
        Text(
            text = label,
            color = Color(0xFF8E8E93),
            fontSize = 10.sp,
            fontWeight = FontWeight.Bold
        )
        Spacer(modifier = Modifier.height(4.dp))
        Text(
            text = value,
            color = Color.White,
            fontSize = 18.sp,
            fontWeight = FontWeight.Bold
        )
    }
}

@Composable
fun TerminateStatCard(
    label: String,
    value: String,
    unit: String,
    backgroundColor: Color,
    modifier: Modifier = Modifier
) {
    Column(
        modifier = modifier
            .clip(RoundedCornerShape(16.dp))
            .background(backgroundColor)
            .padding(16.dp)
    ) {
        Text(
            text = label,
            color = Color(0xFF8E8E93),
            fontSize = 10.sp,
            fontWeight = FontWeight.Bold
        )
        Spacer(modifier = Modifier.height(4.dp))
        Row(verticalAlignment = Alignment.Bottom) {
            Text(
                text = value,
                color = Color.White,
                fontSize = 20.sp,
                fontWeight = FontWeight.Black
            )
            Spacer(modifier = Modifier.width(4.dp))
            Text(
                text = unit,
                color = Color.White,
                fontSize = 12.sp,
                modifier = Modifier.padding(bottom = 2.dp)
            )
        }
    }
}

@Composable
fun TerminateOptionItem(
    iconRes: Int,
    title: String,
    backgroundColor: Color,
    onClick: () -> Unit = {},
    trailing: (@Composable () -> Unit)? = null
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(16.dp))
            .background(backgroundColor)
            .clickable { onClick() }
            .padding(horizontal = 16.dp, vertical = 16.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Icon(
            painter = painterResource(id = iconRes),
            contentDescription = null,
            tint = Color(0xFFD0FD3E),
            modifier = Modifier.size(20.dp)
        )
        Spacer(modifier = Modifier.width(16.dp))
        Text(
            text = title,
            color = Color.White,
            fontSize = 15.sp,
            fontWeight = FontWeight.Medium,
            modifier = Modifier.weight(1f)
        )
        if (trailing != null) {
            trailing()
        } else {
            Icon(
                painter = painterResource(id = R.drawable.ic_chevron_right),
                contentDescription = null,
                tint = Color.White,
                modifier = Modifier.size(20.dp)
            )
        }
    }
}

@Composable
fun TerminateSection(
    onDeleteClick: () -> Unit,
    warningColor: Color,
    backgroundColor: Color
) {
    var understandRisks by remember { mutableStateOf(false) }

    Column(
        modifier = Modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(24.dp))
            .background(backgroundColor)
            .border(1.dp, warningColor.copy(alpha = 0.2f), RoundedCornerShape(24.dp))
            .padding(24.dp)
    ) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            Icon(
                painter = painterResource(id = R.drawable.ic_warning),
                contentDescription = null,
                tint = warningColor,
                modifier = Modifier.size(24.dp)
            )
            Spacer(modifier = Modifier.width(16.dp))
            Text(
                text = "TERMINATE\nACCOUNT",
                color = warningColor,
                fontSize = 20.sp,
                fontWeight = FontWeight.Black,
                lineHeight = 22.sp
            )
        }

        Spacer(modifier = Modifier.height(16.dp))

        Text(
            text = "This action is permanent and cannot be undone. All workout history, physiological data, and earned badges will be purged from the Forge Performance servers.",
            color = Color(0xFF8E8E93),
            fontSize = 12.sp,
            lineHeight = 18.sp,
            fontWeight = FontWeight.Medium
        )

        Spacer(modifier = Modifier.height(24.dp))

        Row(
            verticalAlignment = Alignment.CenterVertically,
            modifier = Modifier.clickable { understandRisks = !understandRisks }
        ) {
            Box(
                modifier = Modifier
                    .size(20.dp)
                    .border(1.dp, Color(0xFF3A3A3C), RoundedCornerShape(4.dp))
                    .background(if (understandRisks) Color(0xFF3A3A3C) else Color.Transparent),
                contentAlignment = Alignment.Center
            ) {
                if (understandRisks) {
                    Icon(
                        painter = painterResource(id = R.drawable.ic_check_simple),
                        contentDescription = null,
                        tint = Color.White,
                        modifier = Modifier.size(12.dp)
                    )
                }
            }
            Spacer(modifier = Modifier.width(12.dp))
            Text(
                text = "I UNDERSTAND THE DATA LOSS RISKS",
                color = Color(0xFF8E8E93),
                fontSize = 10.sp,
                fontWeight = FontWeight.Bold
            )
        }

        Spacer(modifier = Modifier.height(24.dp))

        Button(
            onClick = onDeleteClick,
            modifier = Modifier
                .fillMaxWidth()
                .height(56.dp),
            shape = RoundedCornerShape(12.dp),
            border = androidx.compose.foundation.BorderStroke(1.dp, warningColor),
            colors = ButtonDefaults.buttonColors(
                containerColor = Color.Transparent,
                contentColor = warningColor
            )
        ) {
            Text(
                text = "DELETE ACCOUNT",
                fontSize = 18.sp,
                fontWeight = FontWeight.Black
            )
        }

        Spacer(modifier = Modifier.height(12.dp))

        Text(
            text = "REQUIRES MULTI-FACTOR VERIFICATION",
            color = Color(0xFF48484A),
            fontSize = 10.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.fillMaxWidth(),
            textAlign = TextAlign.Center
        )
    }
}

@Composable
fun TerminateAccountBottomNav(accentColor: Color) {
    NavigationBar(
        containerColor = Color.Black,
        tonalElevation = 0.dp
    ) {
        val items = listOf(
            Triple("Dash", R.drawable.ic_nav_dash, false),
            Triple("Train", R.drawable.ic_nav_train, false),
            Triple("Fuel", R.drawable.ic_nav_fuel, false),
            Triple("Goals", R.drawable.ic_history, false),
            Triple("Admin", R.drawable.ic_biometric, true)
        )

        items.forEach { (label, iconRes, isSelected) ->
            NavigationBarItem(
                selected = isSelected,
                onClick = { },
                icon = {
                    if (isSelected) {
                        Box(
                            modifier = Modifier
                                .size(36.dp)
                                .clip(CircleShape)
                                .background(accentColor),
                            contentAlignment = Alignment.Center
                        ) {
                            Icon(
                                painter = painterResource(id = iconRes),
                                contentDescription = null,
                                tint = Color.Black,
                                modifier = Modifier.size(20.dp)
                            )
                        }
                    } else {
                        Icon(
                            painter = painterResource(id = iconRes),
                            contentDescription = null,
                            tint = Color.White,
                            modifier = Modifier.size(24.dp)
                        )
                    }
                },
                label = {
                    Text(
                        text = label,
                        color = if (isSelected) accentColor else Color.White,
                        fontSize = 10.sp,
                        fontWeight = if (isSelected) FontWeight.Bold else FontWeight.Medium
                    )
                },
                colors = NavigationBarItemDefaults.colors(
                    indicatorColor = Color.Transparent
                )
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun TerminateAccountScreenPreview() {
    MaterialTheme {
        TerminateAccountScreen()
    }
}
