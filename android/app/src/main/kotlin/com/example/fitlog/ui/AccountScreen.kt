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
import androidx.compose.ui.draw.scale
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
fun AccountScreen(
    modifier: Modifier = Modifier,
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

    Scaffold(
        modifier = modifier.fillMaxSize(),
        containerColor = backgroundColor,
        topBar = {
            AccountTopBar()
        },
        bottomBar = {
            AccountBottomNavigationBar(accentColor = accentColor)
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
            
            // Header Section
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.Bottom
            ) {
                Column {
                    Text(
                        text = stringResource(R.string.athlete_profile),
                        color = accentColor,
                        fontSize = 11.sp,
                        fontWeight = FontWeight.Bold,
                        letterSpacing = 0.5.sp
                    )
                    Text(
                        text = stringResource(R.string.account_title),
                        color = textColor,
                        fontSize = 34.sp,
                        fontWeight = FontWeight.Black
                    )
                }
                Text(
                    text = stringResource(R.string.member_since, "MAR 2023"),
                    color = textColor,
                    fontSize = 11.sp,
                    fontWeight = FontWeight.Bold,
                    textAlign = TextAlign.End,
                    lineHeight = 14.sp
                )
            }

            Spacer(modifier = Modifier.height(32.dp))

            // Personal Details Section
            SectionHeader(
                title = stringResource(R.string.personal_details),
                actionText = stringResource(R.string.edit_all),
                onActionClick = onEditAllClick,
                accentColor = accentColor
            )

            Spacer(modifier = Modifier.height(16.dp))

            DetailCard(
                label = stringResource(R.string.full_name_label),
                value = "Alex Sterling",
                backgroundColor = cardBackgroundColor
            )

            Spacer(modifier = Modifier.height(12.dp))

            DetailCard(
                label = stringResource(R.string.email_address_label),
                value = "a.sterling.performance@forge.com",
                backgroundColor = cardBackgroundColor
            )

            Spacer(modifier = Modifier.height(12.dp))

            Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(12.dp)) {
                StatCard(
                    label = stringResource(R.string.height_label),
                    value = "188",
                    unit = "cm",
                    modifier = Modifier.weight(1f),
                    backgroundColor = cardBackgroundColor
                )
                StatCard(
                    label = stringResource(R.string.weight_label),
                    value = "92.4",
                    unit = "kg",
                    modifier = Modifier.weight(1f),
                    backgroundColor = cardBackgroundColor
                )
                StatCard(
                    label = stringResource(R.string.body_fat_label),
                    value = "10.2",
                    unit = "%",
                    modifier = Modifier.weight(1f),
                    backgroundColor = cardBackgroundColor
                )
            }

            Spacer(modifier = Modifier.height(40.dp))

            // Security & Privacy Section
            Text(
                text = stringResource(R.string.security_privacy),
                color = textColor,
                fontSize = 18.sp,
                fontWeight = FontWeight.Black
            )

            Spacer(modifier = Modifier.height(16.dp))

            SecurityOptionCard(
                iconRes = R.drawable.ic_lock,
                title = stringResource(R.string.update_password),
                onClick = onUpdatePasswordClick,
                backgroundColor = cardBackgroundColor
            )

            Spacer(modifier = Modifier.height(12.dp))

            var biometricEnabled by remember { mutableStateOf(true) }
            SecurityOptionCard(
                iconRes = R.drawable.ic_biometric,
                title = stringResource(R.string.biometric_authentication),
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
                        ),
                        modifier = Modifier.scale(0.7f)
                    )
                },
                backgroundColor = cardBackgroundColor
            )

            Spacer(modifier = Modifier.height(12.dp))

            SecurityOptionCard(
                iconRes = R.drawable.ic_history,
                title = stringResource(R.string.data_export_history),
                onClick = onDataExportClick,
                backgroundColor = cardBackgroundColor
            )

            Spacer(modifier = Modifier.height(40.dp))

            // Terminate Account Section
            TerminateAccountCard(
                onDeleteClick = onDeleteAccountClick,
                warningColor = warningColor,
                cardBackgroundColor = Color(0xFF1F1210)
            )

            Spacer(modifier = Modifier.height(40.dp))
        }
    }
}

@Composable
fun AccountTopBar() {
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

@Composable
fun SectionHeader(
    title: String,
    actionText: String,
    onActionClick: () -> Unit,
    accentColor: Color
) {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Text(
            text = title,
            color = Color.White,
            fontSize = 18.sp,
            fontWeight = FontWeight.Black
        )
        Text(
            text = actionText,
            color = accentColor,
            fontSize = 11.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.clickable { onActionClick() }
        )
    }
}

@Composable
fun DetailCard(
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
        Text(text = label, color = Color(0xFF8E8E93), fontSize = 10.sp, fontWeight = FontWeight.Bold)
        Spacer(modifier = Modifier.height(4.dp))
        Text(text = value, color = Color.White, fontSize = 16.sp, fontWeight = FontWeight.Bold)
    }
}

@Composable
fun StatCard(
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
        Text(text = label, color = Color(0xFF8E8E93), fontSize = 10.sp, fontWeight = FontWeight.Bold)
        Spacer(modifier = Modifier.height(4.dp))
        Row(verticalAlignment = Alignment.Bottom) {
            Text(text = value, color = Color.White, fontSize = 20.sp, fontWeight = FontWeight.Black)
            Spacer(modifier = Modifier.width(4.dp))
            Text(text = unit, color = Color.White, fontSize = 12.sp, modifier = Modifier.padding(bottom = 2.dp))
        }
    }
}

@Composable
fun SecurityOptionCard(
    iconRes: Int,
    title: String,
    onClick: () -> Unit = {},
    trailing: (@Composable () -> Unit)? = null,
    backgroundColor: Color
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
            fontSize = 14.sp,
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
                modifier = Modifier.size(16.dp)
            )
        }
    }
}

@Composable
fun TerminateAccountCard(
    onDeleteClick: () -> Unit,
    warningColor: Color,
    cardBackgroundColor: Color
) {
    var checked by remember { mutableStateOf(false) }

    Column(
        modifier = Modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(24.dp))
            .background(cardBackgroundColor)
            .padding(24.dp)
    ) {
        Row(verticalAlignment = Alignment.Top) {
            Icon(
                painter = painterResource(id = R.drawable.ic_warning),
                contentDescription = null,
                tint = warningColor,
                modifier = Modifier.size(24.dp)
            )
            Spacer(modifier = Modifier.width(16.dp))
            Text(
                text = stringResource(R.string.terminate_account),
                color = warningColor,
                fontSize = 20.sp,
                fontWeight = FontWeight.Black,
                lineHeight = 22.sp
            )
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        Text(
            text = stringResource(R.string.terminate_description),
            color = Color(0xFF8E8E93),
            fontSize = 12.sp,
            lineHeight = 18.sp,
            fontWeight = FontWeight.Medium
        )

        Spacer(modifier = Modifier.height(24.dp))

        Row(
            verticalAlignment = Alignment.CenterVertically,
            modifier = Modifier.clickable { checked = !checked }
        ) {
            Box(
                modifier = Modifier
                    .size(20.dp)
                    .border(1.dp, Color(0xFF3A3A3C), RoundedCornerShape(4.dp))
                    .background(if (checked) Color(0xFF3A3A3C) else Color.Transparent),
                contentAlignment = Alignment.Center
            ) {
                if (checked) {
                    Icon(
                        painter = painterResource(id = R.drawable.ic_chevron_right),
                        contentDescription = null,
                        tint = Color.White,
                        modifier = Modifier.size(12.dp)
                    )
                }
            }
            Spacer(modifier = Modifier.width(12.dp))
            Text(
                text = stringResource(R.string.understand_risks),
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
            colors = ButtonDefaults.buttonColors(containerColor = Color.Transparent, contentColor = warningColor)
        ) {
            Text(
                text = stringResource(R.string.delete_account),
                fontSize = 16.sp,
                fontWeight = FontWeight.Black
            )
        }

        Spacer(modifier = Modifier.height(12.dp))

        Text(
            text = stringResource(R.string.mfa_required),
            color = Color(0xFF48484A),
            fontSize = 10.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.fillMaxWidth(),
            textAlign = TextAlign.Center
        )
    }
}

private data class AccountNavItem(val labelRes: Int, val iconRes: Int, val isSelected: Boolean)

@Composable
fun AccountBottomNavigationBar(accentColor: Color) {
    NavigationBar(
        containerColor = Color.Black,
        tonalElevation = 0.dp
    ) {
        val items = listOf(
            AccountNavItem(R.string.nav_dash, R.drawable.ic_nav_dash, false),
            AccountNavItem(R.string.nav_train, R.drawable.ic_nav_train, false),
            AccountNavItem(R.string.nav_fuel, R.drawable.ic_nav_fuel, false),
            AccountNavItem(R.string.nav_goals, R.drawable.ic_history, false),
            AccountNavItem(R.string.nav_admin, R.drawable.ic_biometric, true)
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
fun AccountScreenPreview() {
    MaterialTheme {
        AccountScreen()
    }
}
