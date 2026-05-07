package com.example.fitlog.ui

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.fitlog.R

@Composable
fun ChangePasswordScreen(
    modifier: Modifier = Modifier,
    onBackClick: () -> Unit = {},
    onSubmitClick: () -> Unit = {},
    onCancelClick: () -> Unit = {}
) {
    var oldPassword by remember { mutableStateOf("") }
    var newPassword by remember { mutableStateOf("") }
    var confirmPassword by remember { mutableStateOf("") }

    val backgroundColor = Color(0xFFa39b8b)
    val inputBackgroundColor = Color(0xFFf5f5f5)
    val textColor = Color(0xFF2d2d2d)
    val secondaryTextColor = Color(0xFF6b6b6b)
    val buttonColor = Color(0xFFd6d1c7)

    Column(
        modifier = modifier
            .fillMaxSize()
            .background(backgroundColor)
            .padding(16.dp)
    ) {
        IconButton(onClick = onBackClick) {
            Box(modifier = Modifier.size(24.dp)) {
                // Placeholder for back icon
                Icon(
                    painter = painterResource(id = android.R.drawable.ic_menu_revert), // Using a system icon as fallback
                    contentDescription = stringResource(id = R.string.back_button_content_description),
                    tint = textColor
                )
            }
        }

        Spacer(modifier = Modifier.height(8.dp))

        Text(
            text = stringResource(id = R.string.change_password_title),
            fontSize = 24.sp,
            fontWeight = FontWeight.Bold,
            color = textColor
        )

        Text(
            text = stringResource(id = R.string.new_credentials_subtitle),
            fontSize = 18.sp,
            fontWeight = FontWeight.Bold,
            color = secondaryTextColor
        )

        Spacer(modifier = Modifier.height(32.dp))

        PasswordField(
            label = stringResource(id = R.string.old_password_label),
            value = oldPassword,
            onValueChange = { oldPassword = it },
            backgroundColor = inputBackgroundColor,
            textColor = textColor
        )

        Spacer(modifier = Modifier.height(16.dp))

        PasswordField(
            label = stringResource(id = R.string.new_password_label),
            value = newPassword,
            onValueChange = { newPassword = it },
            backgroundColor = inputBackgroundColor,
            textColor = textColor
        )

        Spacer(modifier = Modifier.height(16.dp))

        PasswordField(
            label = stringResource(id = R.string.confirm_password_label),
            value = confirmPassword,
            onValueChange = { confirmPassword = it },
            backgroundColor = inputBackgroundColor,
            textColor = textColor
        )

        Spacer(modifier = Modifier.height(24.dp))

        PasswordRequirements(textColor = Color(0xFFe0e0e0))

        Spacer(modifier = Modifier.weight(1f))

        Button(
            onClick = onSubmitClick,
            modifier = Modifier
                .fillMaxWidth(0.5f)
                .height(48.dp)
                .align(Alignment.CenterHorizontally),
            colors = ButtonDefaults.buttonColors(containerColor = buttonColor),
            shape = RoundedCornerShape(24.dp)
        ) {
            Text(
                text = stringResource(id = R.string.submit_button),
                color = Color.Black,
                fontWeight = FontWeight.Bold,
                fontSize = 18.sp
            )
        }

        Spacer(modifier = Modifier.height(12.dp))

        Button(
            onClick = onCancelClick,
            modifier = Modifier
                .fillMaxWidth(0.5f)
                .height(48.dp)
                .align(Alignment.CenterHorizontally),
            colors = ButtonDefaults.buttonColors(containerColor = buttonColor.copy(alpha = 0.7f)),
            shape = RoundedCornerShape(24.dp)
        ) {
            Text(
                text = stringResource(id = R.string.cancel_button),
                color = textColor,
                fontWeight = FontWeight.Bold,
                fontSize = 18.sp
            )
        }
        
        Spacer(modifier = Modifier.height(24.dp))
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun PasswordField(
    label: String,
    value: String,
    onValueChange: (String) -> Unit,
    backgroundColor: Color,
    textColor: Color,
    modifier: Modifier = Modifier
) {
    Column(modifier = modifier.fillMaxWidth()) {
        Text(
            text = label,
            fontSize = 14.sp,
            fontWeight = FontWeight.Bold,
            color = textColor,
            modifier = Modifier.padding(bottom = 8.dp)
        )
        TextField(
            value = value,
            onValueChange = onValueChange,
            modifier = Modifier
                .fillMaxWidth()
                .height(56.dp),
            shape = RoundedCornerShape(12.dp),
            colors = TextFieldDefaults.colors(
                focusedContainerColor = backgroundColor,
                unfocusedContainerColor = backgroundColor,
                disabledContainerColor = backgroundColor,
                focusedIndicatorColor = Color.Transparent,
                unfocusedIndicatorColor = Color.Transparent,
            )
        )
    }
}

@Composable
fun PasswordRequirements(
    textColor: Color,
    modifier: Modifier = Modifier
) {
    Column(modifier = modifier.fillMaxWidth(), verticalArrangement = Arrangement.spacedBy(4.dp)) {
        Text(
            text = stringResource(id = R.string.password_requirement_length),
            fontSize = 14.sp,
            color = textColor
        )
        Text(
            text = stringResource(id = R.string.password_requirement_uppercase),
            fontSize = 14.sp,
            color = textColor
        )
        Text(
            text = stringResource(id = R.string.password_requirement_lowercase),
            fontSize = 14.sp,
            color = textColor
        )
        Text(
            text = stringResource(id = R.string.password_requirement_special),
            fontSize = 14.sp,
            color = textColor
        )
    }
}

@Preview(showBackground = true)
@Composable
fun ChangePasswordScreenPreview() {
    MaterialTheme {
        ChangePasswordScreen()
    }
}
