package com.example.fitlog.ui

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.border
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
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.fitlog.R

@Composable
fun SecurityProtocolScreen(
    modifier: Modifier = Modifier,
    onAuthorizeUpdate: () -> Unit = {},
    onCancelRequest: () -> Unit = {}
) {
    val backgroundColor = Color(0xFF0A0A0A)
    val accentColor = Color(0xFFC6FF00) // Neon Yellow/Green
    val surfaceColor = Color(0xFF141414)
    val inputBackgroundColor = Color(0xFF1A1A1A)
    val textColor = Color.White
    val secondaryTextColor = Color(0xFF8E8E8E)
    val dangerColor = Color(0xFFFF4D4D)

    Column(
        modifier = modifier
            .fillMaxSize()
            .background(backgroundColor)
            .verticalScroll(rememberScrollState())
            .padding(horizontal = 20.dp, vertical = 24.dp)
    ) {
        // Top Bar
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 32.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            // Profile Placeholder
            Box(
                modifier = Modifier
                    .size(40.dp)
                    .clip(CircleShape)
                    .border(1.dp, Color(0xFF333333), CircleShape)
                    .background(Color(0xFF1A1A1A)),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    painter = painterResource(id = android.R.drawable.ic_menu_myplaces),
                    contentDescription = null,
                    tint = Color.Gray,
                    modifier = Modifier.size(24.dp)
                )
            }

            Text(
                text = stringResource(id = R.string.fitlog_logo),
                color = textColor,
                fontSize = 20.sp,
                fontWeight = FontWeight.Black,
                letterSpacing = 2.sp
            )

            Icon(
                painter = painterResource(id = android.R.drawable.ic_popup_reminder),
                contentDescription = null,
                tint = textColor,
                modifier = Modifier.size(24.dp)
            )
        }

        // Section Title
        Row(
            verticalAlignment = Alignment.CenterVertically,
            modifier = Modifier.padding(bottom = 12.dp)
        ) {
            Icon(
                painter = painterResource(id = android.R.drawable.ic_lock_idle_lock),
                contentDescription = null,
                tint = accentColor,
                modifier = Modifier.size(14.dp)
            )
            Spacer(modifier = Modifier.width(8.dp))
            Text(
                text = stringResource(id = R.string.security_protocol),
                color = accentColor,
                fontSize = 10.sp,
                fontWeight = FontWeight.Bold,
                letterSpacing = 1.sp
            )
        }

        Text(
            text = stringResource(id = R.string.change_password_title),
            color = textColor,
            fontSize = 36.sp,
            fontWeight = FontWeight.Black,
            lineHeight = 40.sp,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        Text(
            text = stringResource(id = R.string.change_password_description),
            color = secondaryTextColor,
            fontSize = 14.sp,
            lineHeight = 20.sp,
            modifier = Modifier.padding(bottom = 32.dp)
        )

        // Input Fields
        SecurityInputField(
            label = stringResource(id = R.string.current_password),
            value = "**********",
            trailingIcon = android.R.drawable.ic_menu_view,
            backgroundColor = inputBackgroundColor
        )

        Spacer(modifier = Modifier.height(20.dp))

        SecurityInputField(
            label = stringResource(id = R.string.new_performance_key),
            value = "**************",
            trailingIcon = android.R.drawable.ic_menu_view,
            borderColor = accentColor,
            backgroundColor = inputBackgroundColor
        )

        Spacer(modifier = Modifier.height(16.dp))

        // Strength Indicator
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .clip(RoundedCornerShape(12.dp))
                .background(surfaceColor)
                .padding(16.dp)
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = stringResource(id = R.string.key_strength_elite),
                    color = accentColor,
                    fontSize = 11.sp,
                    fontWeight = FontWeight.Bold
                )
                Text(
                    text = stringResource(id = R.string.key_strength_percentage),
                    color = accentColor,
                    fontSize = 11.sp,
                    fontWeight = FontWeight.Bold
                )
            }
            Spacer(modifier = Modifier.height(8.dp))
            LinearProgressIndicator(
                progress = 0.75f,
                modifier = Modifier
                    .fillMaxWidth()
                    .height(4.dp)
                    .clip(CircleShape),
                color = accentColor,
                trackColor = Color(0xFF262626)
            )
            Spacer(modifier = Modifier.height(16.dp))

            // Requirements
            Row(modifier = Modifier.fillMaxWidth()) {
                Column(modifier = Modifier.weight(1f)) {
                    RequirementItem(text = stringResource(id = R.string.requirement_min_chars), isChecked = true, accentColor = accentColor)
                    RequirementItem(text = stringResource(id = R.string.requirement_numeric_value), isChecked = true, accentColor = accentColor)
                }
                Column(modifier = Modifier.weight(1f)) {
                    RequirementItem(text = stringResource(id = R.string.requirement_special_symbol), isChecked = true, accentColor = accentColor)
                    RequirementItem(text = stringResource(id = R.string.requirement_uppercase_delta), isChecked = false, accentColor = accentColor)
                }
            }
        }

        Spacer(modifier = Modifier.height(20.dp))

        SecurityInputField(
            label = stringResource(id = R.string.confirm_new_key),
            value = "**********",
            backgroundColor = inputBackgroundColor
        )

        Spacer(modifier = Modifier.height(32.dp))

        // Buttons
        Button(
            onClick = onAuthorizeUpdate,
            modifier = Modifier
                .fillMaxWidth()
                .height(56.dp),
            colors = ButtonDefaults.buttonColors(containerColor = accentColor),
            shape = RoundedCornerShape(8.dp)
        ) {
            Row(verticalAlignment = Alignment.CenterVertically) {
                Text(
                    text = stringResource(id = R.string.authorize_update),
                    color = Color.Black,
                    fontWeight = FontWeight.Black,
                    fontSize = 14.sp
                )
                Spacer(modifier = Modifier.width(8.dp))
                Icon(
                    painter = painterResource(id = android.R.drawable.ic_lock_idle_lock),
                    contentDescription = null,
                    tint = Color.Black,
                    modifier = Modifier.size(16.dp)
                )
            }
        }

        Spacer(modifier = Modifier.height(12.dp))

        OutlinedButton(
            onClick = onCancelRequest,
            modifier = Modifier
                .fillMaxWidth()
                .height(56.dp),
            shape = RoundedCornerShape(8.dp),
            border = BorderStroke(1.dp, Color(0xFF262626)),
            colors = ButtonDefaults.outlinedButtonColors(contentColor = textColor)
        ) {
            Text(
                text = stringResource(id = R.string.cancel_request),
                fontWeight = FontWeight.Bold,
                fontSize = 14.sp,
                color = Color(0xFFB0B0B0)
            )
        }

        Spacer(modifier = Modifier.height(40.dp))

        // Footer Card
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .clip(RoundedCornerShape(16.dp))
                .background(surfaceColor)
                .padding(20.dp)
        ) {
            // Background Icon
            Icon(
                painter = painterResource(id = android.R.drawable.ic_lock_idle_lock),
                contentDescription = null,
                tint = Color.White.copy(alpha = 0.03f),
                modifier = Modifier
                    .size(100.dp)
                    .align(Alignment.CenterEnd)
                    .offset(x = 20.dp, y = 10.dp)
            )

            Column {
                Text(
                    text = stringResource(id = R.string.data_integrity_title),
                    color = textColor,
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(bottom = 8.dp)
                )
                Text(
                    text = stringResource(id = R.string.data_integrity_description),
                    color = secondaryTextColor,
                    fontSize = 13.sp,
                    lineHeight = 18.sp,
                    modifier = Modifier.padding(bottom = 16.dp)
                )
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Box(
                        modifier = Modifier
                            .size(6.dp)
                            .background(dangerColor, CircleShape)
                    )
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(
                        text = stringResource(id = R.string.end_to_end_encrypted),
                        color = dangerColor,
                        fontSize = 10.sp,
                        fontWeight = FontWeight.Black,
                        letterSpacing = 1.sp
                    )
                }
            }
        }
        
        Spacer(modifier = Modifier.height(24.dp))
    }
}

@Composable
fun SecurityInputField(
    label: String,
    value: String,
    modifier: Modifier = Modifier,
    trailingIcon: Int? = null,
    borderColor: Color = Color.Transparent,
    backgroundColor: Color = Color(0xFF1A1A1A)
) {
    Column(modifier = modifier.fillMaxWidth()) {
        Text(
            text = label,
            color = Color(0xFF666666),
            fontSize = 10.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.padding(bottom = 8.dp)
        )
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(56.dp)
                .clip(RoundedCornerShape(8.dp))
                .background(backgroundColor)
                .then(
                    if (borderColor != Color.Transparent) {
                        Modifier.border(1.dp, borderColor, RoundedCornerShape(8.dp))
                    } else Modifier
                )
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
                    fontSize = 14.sp,
                    letterSpacing = 2.sp
                )
                if (trailingIcon != null) {
                    Icon(
                        painter = painterResource(id = trailingIcon),
                        contentDescription = null,
                        tint = if (borderColor != Color.Transparent) borderColor else Color(0xFF444444),
                        modifier = Modifier.size(20.dp)
                    )
                }
            }
        }
    }
}

@Composable
fun RequirementItem(
    text: String,
    isChecked: Boolean,
    accentColor: Color,
    modifier: Modifier = Modifier
) {
    Row(
        modifier = modifier.padding(vertical = 4.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Icon(
            painter = painterResource(
                id = if (isChecked) android.R.drawable.checkbox_on_background else android.R.drawable.checkbox_off_background
            ),
            contentDescription = null,
            tint = if (isChecked) accentColor else Color(0xFF444444),
            modifier = Modifier.size(12.dp)
        )
        Spacer(modifier = Modifier.width(8.dp))
        Text(
            text = text,
            color = if (isChecked) accentColor else Color(0xFF666666),
            fontSize = 11.sp
        )
    }
}

@Preview
@Composable
fun SecurityProtocolScreenPreview() {
    MaterialTheme {
        SecurityProtocolScreen()
    }
}
