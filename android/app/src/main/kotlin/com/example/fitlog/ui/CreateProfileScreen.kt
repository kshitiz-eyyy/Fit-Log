package com.example.fitlog.ui

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.SpanStyle
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.fitlog.R

private val DarkBackground = Color(0xFF121212)
private val SurfaceDark = Color(0xFF1E1E1E)
private val PrimaryOrange = Color(0xFFFF6D00)
private val SecondaryLime = Color(0xFFC6FF00)
private val TextGray = Color(0xFFBDBDBD)
private val IndicatorGray = Color(0xFF333333)

@Composable
fun CreateProfileScreen(
    modifier: Modifier = Modifier,
    onBackClick: () -> Unit = {},
    onNotificationClick: () -> Unit = {},
    onCreateAccountClick: () -> Unit = {},
    onLoginClick: () -> Unit = {}
) {
    var fullName by remember { mutableStateOf("") }
    var email by remember { mutableStateOf("") }
    var password by remember { mutableStateOf("") }
    var age by remember { mutableStateOf("25") }
    var gender by remember { mutableStateOf("Male") }
    var height by remember { mutableStateOf("180") }
    var weight by remember { mutableStateOf("75") }
    var selectedGoal by remember { mutableStateOf("Muscle Gain") }

    Surface(
        modifier = modifier.fillMaxSize(),
        color = DarkBackground
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .verticalScroll(rememberScrollState())
        ) {
            // Top Bar
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 8.dp, vertical = 8.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                IconButton(onClick = onBackClick) {
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
                    fontWeight = FontWeight.Black,
                    letterSpacing = 1.sp
                )
                IconButton(onClick = onNotificationClick) {
                    Icon(
                        painter = painterResource(id = R.drawable.ic_notifications),
                        contentDescription = "Notifications",
                        tint = Color.White,
                        modifier = Modifier.size(24.dp)
                    )
                }
            }

            Column(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 24.dp)
            ) {
                Spacer(modifier = Modifier.height(32.dp))

                Text(
                    text = stringResource(id = R.string.create_profile_title),
                    color = Color.White,
                    fontSize = 44.sp,
                    lineHeight = 44.sp,
                    fontWeight = FontWeight.Black,
                    modifier = Modifier.padding(bottom = 8.dp)
                )

                Text(
                    text = stringResource(id = R.string.create_profile_subtitle),
                    color = TextGray,
                    fontSize = 14.sp,
                    lineHeight = 20.sp,
                    modifier = Modifier.padding(bottom = 32.dp)
                )

                ProfileTextField(
                    label = stringResource(id = R.string.full_name_label),
                    value = fullName,
                    onValueChange = { fullName = it },
                    placeholder = stringResource(id = R.string.full_name_hint)
                )

                Spacer(modifier = Modifier.height(24.dp))

                ProfileTextField(
                    label = stringResource(id = R.string.email_label_cp),
                    value = email,
                    onValueChange = { email = it },
                    placeholder = stringResource(id = R.string.email_hint_cp)
                )

                Spacer(modifier = Modifier.height(24.dp))

                ProfileTextField(
                    label = stringResource(id = R.string.password_label_cp),
                    value = password,
                    onValueChange = { password = it },
                    placeholder = stringResource(id = R.string.password_hint_cp),
                    isPassword = true
                )

                Spacer(modifier = Modifier.height(12.dp))

                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.spacedBy(4.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    repeat(4) { index ->
                        Box(
                            modifier = Modifier
                                .weight(1f)
                                .height(4.dp)
                                .background(
                                    color = if (index == 0) Color.DarkGray else IndicatorGray,
                                    shape = RoundedCornerShape(2.dp)
                                )
                        )
                    }
                    Text(
                        text = stringResource(id = R.string.required_label),
                        color = Color.Gray,
                        fontSize = 9.sp,
                        fontWeight = FontWeight.Bold,
                        modifier = Modifier.padding(start = 8.dp)
                    )
                }

                Spacer(modifier = Modifier.height(32.dp))

                Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(16.dp)) {
                    ProfileDropdownField(
                        label = stringResource(id = R.string.age_label),
                        value = age,
                        modifier = Modifier.weight(1f)
                    )
                    ProfileDropdownField(
                        label = stringResource(id = R.string.gender_label),
                        value = gender,
                        modifier = Modifier.weight(1f),
                        isGender = true
                    )
                }

                Spacer(modifier = Modifier.height(20.dp))

                Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(16.dp)) {
                    ProfileDropdownField(
                        label = stringResource(id = R.string.height_label),
                        value = height,
                        modifier = Modifier.weight(1f)
                    )
                    ProfileDropdownField(
                        label = stringResource(id = R.string.weight_label),
                        value = weight,
                        modifier = Modifier.weight(1f)
                    )
                }

                Spacer(modifier = Modifier.height(32.dp))

                Text(
                    text = stringResource(id = R.string.fitness_goal_label),
                    color = Color.White,
                    fontSize = 12.sp,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(bottom = 12.dp)
                )

                FitnessGoalItem(
                    title = stringResource(id = R.string.muscle_gain),
                    iconRes = R.drawable.ic_muscle,
                    isSelected = selectedGoal == "Muscle Gain",
                    onClick = { selectedGoal = "Muscle Gain" }
                )

                FitnessGoalItem(
                    title = stringResource(id = R.string.weight_loss),
                    iconRes = R.drawable.ic_running,
                    isSelected = selectedGoal == "Weight Loss",
                    onClick = { selectedGoal = "Weight Loss" }
                )

                FitnessGoalItem(
                    title = stringResource(id = R.string.endurance),
                    iconRes = R.drawable.ic_bolt,
                    isSelected = selectedGoal == "Endurance",
                    onClick = { selectedGoal = "Endurance" }
                )

                Spacer(modifier = Modifier.height(48.dp))

                Button(
                    onClick = onCreateAccountClick,
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(60.dp),
                    colors = ButtonDefaults.buttonColors(
                        containerColor = PrimaryOrange
                    ),
                    shape = RoundedCornerShape(12.dp)
                ) {
                    Text(
                        text = stringResource(id = R.string.create_account_btn),
                        fontSize = 20.sp,
                        fontWeight = FontWeight.Black,
                        color = Color.Black
                    )
                }

                Spacer(modifier = Modifier.height(32.dp))

                Box(
                    modifier = Modifier.fillMaxWidth(),
                    contentAlignment = Alignment.Center
                ) {
                    Text(
                        text = buildAnnotatedString {
                            append(stringResource(id = R.string.already_have_account))
                            withStyle(style = SpanStyle(color = SecondaryLime, fontWeight = FontWeight.Bold)) {
                                append(stringResource(id = R.string.login_link))
                            }
                        },
                        color = TextGray,
                        fontSize = 14.sp,
                        modifier = Modifier
                            .clickable { onLoginClick() }
                            .padding(bottom = 40.dp)
                    )
                }
            }
        }
    }
}

@Composable
fun ProfileTextField(
    label: String,
    value: String,
    onValueChange: (String) -> Unit,
    placeholder: String,
    isPassword: Boolean = false,
    modifier: Modifier = Modifier
) {
    Column(modifier = modifier) {
        Text(
            text = label,
            color = TextGray,
            fontSize = 12.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.padding(bottom = 8.dp)
        )
        TextField(
            value = value,
            onValueChange = onValueChange,
            modifier = Modifier.fillMaxWidth(),
            placeholder = {
                Text(
                    text = placeholder,
                    color = Color.Gray.copy(alpha = 0.6f),
                    fontSize = 14.sp
                )
            },
            colors = TextFieldDefaults.colors(
                focusedContainerColor = SurfaceDark,
                unfocusedContainerColor = SurfaceDark,
                focusedIndicatorColor = Color.Transparent,
                unfocusedIndicatorColor = Color.Transparent,
                cursorColor = PrimaryOrange,
                focusedTextColor = Color.White,
                unfocusedTextColor = Color.White
            ),
            shape = RoundedCornerShape(12.dp),
            singleLine = true
        )
    }
}

@Composable
fun ProfileDropdownField(
    label: String,
    value: String,
    modifier: Modifier = Modifier,
    isGender: Boolean = false
) {
    Column(modifier = modifier) {
        Text(
            text = label,
            color = TextGray,
            fontSize = 12.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.padding(bottom = 8.dp)
        )
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(56.dp)
                .background(SurfaceDark, RoundedCornerShape(12.dp))
                .padding(horizontal = 16.dp),
            contentAlignment = Alignment.CenterStart
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = value,
                    color = Color.White,
                    fontSize = 14.sp
                )
                Icon(
                    painter = painterResource(id = if (isGender) R.drawable.ic_expand_more else R.drawable.ic_unfold_more),
                    contentDescription = null,
                    tint = Color.Gray,
                    modifier = Modifier.size(18.dp)
                )
            }
        }
    }
}

@Composable
fun FitnessGoalItem(
    title: String,
    iconRes: Int,
    isSelected: Boolean,
    onClick: () -> Unit,
    modifier: Modifier = Modifier
) {
    Box(
        modifier = modifier
            .fillMaxWidth()
            .padding(vertical = 6.dp)
            .height(64.dp)
            .background(SurfaceDark, RoundedCornerShape(12.dp))
            .border(
                width = if (isSelected) 1.dp else 0.dp,
                color = if (isSelected) SecondaryLime else Color.Transparent,
                shape = RoundedCornerShape(12.dp)
            )
            .clickable { onClick() }
            .padding(horizontal = 20.dp),
        contentAlignment = Alignment.CenterStart
    ) {
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(
                text = title,
                color = if (isSelected) SecondaryLime else Color.White,
                fontSize = 16.sp,
                fontWeight = if (isSelected) FontWeight.Bold else FontWeight.Medium
            )
            Icon(
                painter = painterResource(id = iconRes),
                contentDescription = null,
                tint = if (isSelected) SecondaryLime else Color.White,
                modifier = Modifier.size(24.dp)
            )
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFF121212)
@Composable
fun CreateProfileScreenPreview() {
    MaterialTheme {
        CreateProfileScreen()
    }
}
