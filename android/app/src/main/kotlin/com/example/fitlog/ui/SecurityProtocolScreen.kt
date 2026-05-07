package com.example.fitlog.ui

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
    val backgroundColor = Color(0xFF0C0C0C)
    val accentColor = Color(0xFFD4FF00)
    val surfaceColor = Color(0xFF1A1A1A)
    val textColor = Color.White
    val secondaryTextColor = Color(0xFFB0B0B0)

    Column(
        modifier = modifier
            .fillMaxSize()
            .background(backgroundColor)
            .verticalScroll(rememberScrollState())
            .padding(24.dp)
    ) {
        // Top Header
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Box(
                modifier = Modifier
                    .size(40.dp)
                    .border(1.dp, Color.Gray, CircleShape),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    painter = painterResource(id = android.R.drawable.ic_menu_myplaces), // Placeholder
                    contentDescription = null,
                    tint = textColor,
                    modifier = Modifier.size(24.dp)
                )
            }
            Text(
                text = stringResource(id = R.string.fitlog_logo),
                color = textColor,
                fontSize = 24.sp,
                fontWeight = FontWeight.Black,
                letterSpacing = 2.sp
            )
            Icon(
                painter = painterResource(id = android.R.drawable.ic_popup_reminder), // Placeholder
                contentDescription = null,
                tint = textColor,
                modifier = Modifier.size(24.dp)
            )
        }

        Spacer(modifier = Modifier.height(32.dp))

        // Security Protocol Label
        Row(verticalAlignment = Alignment.CenterVertically) {
            Icon(
                painter = painterResource(id = android.R.drawable.ic_lock_idle_lock), // Placeholder
                contentDescription = null,
                tint = accentColor,
                modifier = Modifier.size(16.dp)
            )
            Spacer(modifier = Modifier.width(8.dp))
            Text(
                text = stringResource(id = R.string.security_protocol),
                color = accentColor,
                fontSize = 12.sp,
                fontWeight = FontWeight.Bold
            )
        }

        Spacer(modifier = Modifier.height(12.dp))

        Text(
            text = stringResource(id = R.string.change_password_title),
            color = textColor,
            fontSize = 32.sp,
            fontWeight = FontWeight.Black,
            lineHeight = 36.sp
        )

        Spacer(modifier = Modifier.height(8.dp))

        Text(
            text = stringResource(id = R.string.change_password_description),
            color = secondaryTextColor,
            fontSize = 14.sp,
            lineHeight = 20.sp
        )

        Spacer(modifier = Modifier.height(32.dp))

        // Form Fields
        SecurityInputField(
            label = stringResource(id = R.string.current_password),
            value = "**********",
            trailingIcon = android.R.drawable.ic_menu_view
        )

        Spacer(modifier = Modifier.height(24.dp))

        SecurityInputField(
            label = stringResource(id = R.string.new_performance_key),
            value = "**************",
            trailingIcon = android.R.drawable.ic_menu_view, // Placeholder for the eye icon in the image
            borderColor = accentColor
        )

        Spacer(modifier = Modifier.height(16.dp))

        // Key Strength Section
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .background(surfaceColor, RoundedCornerShape(12.dp))
                .padding(16.dp)
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                Text(
                    text = stringResource(id = R.string.key_strength_elite),
                    color = accentColor,
                    fontSize = 12.sp,
                    fontWeight = FontWeight.Bold
                )
                Text(
                    text = stringResource(id = R.string.key_strength_percentage),
                    color = accentColor,
                    fontSize = 12.sp,
                    fontWeight = FontWeight.Bold
                )
            }
            Spacer(modifier = Modifier.height(8.dp))
            LinearProgressIndicator(
                progress = 0.75f,
                modifier = Modifier
                    .fillMaxWidth()
                    .height(4.dp),
                color = accentColor,
                trackColor = Color.DarkGray
            )
            Spacer(modifier = Modifier.height(16.dp))
            
            // Requirements Grid
            Row(modifier = Modifier.fillMaxWidth()) {
                Column(modifier = Modifier.weight(1f)) {
                    RequirementItem(text = stringResource(id = R.string.requirement_min_chars), isChecked = true)
                    RequirementItem(text = stringResource(id = R.string.requirement_numeric_value), isChecked = true)
                }
                Column(modifier = Modifier.weight(1f)) {
                    RequirementItem(text = stringResource(id = R.string.requirement_special_symbol), isChecked = true)
                    RequirementItem(text = stringResource(id = R.string.requirement_uppercase_delta), isChecked = false)
                }
            }
        }

        Spacer(modifier = Modifier.height(24.dp))

        SecurityInputField(
            label = stringResource(id = R.string.confirm_new_key),
            value = "**********"
        )

        Spacer(modifier = Modifier.height(32.dp))

        // Actions
        Button(
            onClick = onAuthorizeUpdate,
            modifier = Modifier
                .fillMaxWidth()
                .height(56.dp),
            colors = ButtonDefaults.buttonColors(containerColor = accentColor),
            shape = RoundedCornerShape(12.dp)
        ) {
            Row(verticalAlignment = Alignment.CenterVertically) {
                Text(
                    text = stringResource(id = R.string.authorize_update),
                    color = Color.Black,
                    fontWeight = FontWeight.Bold
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
            colors = ButtonDefaults.outlinedButtonColors(contentColor = textColor),
            shape = RoundedCornerShape(12.dp),
            border = BorderStroke(1.dp, surfaceColor)
        ) {
            Text(
                text = stringResource(id = R.string.cancel_request),
                fontWeight = FontWeight.Bold
            )
        }

        Spacer(modifier = Modifier.height(32.dp))

        // Data Integrity Card
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .background(surfaceColor, RoundedCornerShape(16.dp))
                .padding(20.dp)
        ) {
            Text(
                text = stringResource(id = R.string.data_integrity_title),
                color = textColor,
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold
            )
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = stringResource(id = R.string.data_integrity_description),
                color = secondaryTextColor,
                fontSize = 13.sp,
                lineHeight = 18.sp
            )
            Spacer(modifier = Modifier.height(16.dp))
            Row(verticalAlignment = Alignment.CenterVertically) {
                Box(
                    modifier = Modifier
                        .size(8.dp)
                        .background(Color(0xFFE94560), CircleShape)
                )
                Spacer(modifier = Modifier.width(8.dp))
                Text(
                    text = stringResource(id = R.string.end_to_end_encrypted),
                    color = Color(0xFFE94560),
                    fontSize = 11.sp,
                    fontWeight = FontWeight.Bold,
                    letterSpacing = 1.sp
                )
            }
        }
    }
}

@Composable
fun SecurityInputField(
    label: String,
    value: String,
    modifier: Modifier = Modifier,
    trailingIcon: Int? = null,
    borderColor: Color = Color.Transparent
) {
    Column(modifier = modifier.fillMaxWidth()) {
        Text(
            text = label,
            color = Color.Gray,
            fontSize = 11.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.padding(bottom = 8.dp)
        )
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(56.dp)
                .background(Color(0xFF1E1E1E), RoundedCornerShape(12.dp))
                .then(
                    if (borderColor != Color.Transparent) {
                        Modifier.border(1.dp, borderColor, RoundedCornerShape(12.dp))
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
                    fontSize = 16.sp
                )
                if (trailingIcon != null) {
                    Icon(
                        painter = painterResource(id = trailingIcon),
                        contentDescription = null,
                        tint = if (borderColor != Color.Transparent) borderColor else Color.Gray,
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
            tint = if (isChecked) Color(0xFFD4FF00) else Color.Gray,
            modifier = Modifier.size(14.dp)
        )
        Spacer(modifier = Modifier.width(8.dp))
        Text(
            text = text,
            color = if (isChecked) Color(0xFFD4FF00) else Color.Gray,
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
