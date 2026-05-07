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

    val backgroundColor = Color(0xFFa29a8a)
    val inputBackgroundColor = Color(0xFFf3f2f1)
    val textColor = Color(0xFF000000)
    val subtitleColor = Color(0xFF4a4a4a)
    val requirementTextColor = Color(0xFFd1cdc5)
    val buttonColor = Color(0xFFd6d1c7)
    val secondaryButtonColor = Color(0xFFb5afa1)

    Column(
        modifier = modifier
            .fillMaxSize()
            .background(backgroundColor)
            .padding(24.dp)
    ) {
        IconButton(
            onClick = onBackClick,
            modifier = Modifier.size(32.dp)
        ) {
            Icon(
                painter = painterResource(id = R.drawable.ic_back_arrow),
                contentDescription = stringResource(id = R.string.back_button_content_description),
                tint = textColor
            )
        }

        Spacer(modifier = Modifier.height(16.dp))

        Text(
            text = stringResource(id = R.string.change_password_title),
            fontSize = 28.sp,
            fontWeight = FontWeight.Black,
            color = textColor
        )

        Text(
            text = stringResource(id = R.string.new_credentials_subtitle),
            fontSize = 18.sp,
            fontWeight = FontWeight.Bold,
            color = subtitleColor
        )

        Spacer(modifier = Modifier.height(32.dp))

        PasswordField(
            label = stringResource(id = R.string.old_password_label),
            value = oldPassword,
            onValueChange = { oldPassword = it },
            backgroundColor = inputBackgroundColor,
            textColor = subtitleColor
        )

        Spacer(modifier = Modifier.height(20.dp))

        PasswordField(
            label = stringResource(id = R.string.new_password_label),
            value = newPassword,
            onValueChange = { newPassword = it },
            backgroundColor = inputBackgroundColor,
            textColor = subtitleColor
        )

        Spacer(modifier = Modifier.height(20.dp))

        PasswordField(
            label = stringResource(id = R.string.confirm_password_label),
            value = confirmPassword,
            onValueChange = { confirmPassword = it },
            backgroundColor = inputBackgroundColor,
            textColor = subtitleColor
        )

        Spacer(modifier = Modifier.height(32.dp))

        PasswordRequirements(textColor = requirementTextColor)

        Spacer(modifier = Modifier.weight(1f))

        Button(
            onClick = onSubmitClick,
            modifier = Modifier
                .fillMaxWidth(0.65f)
                .height(56.dp)
                .align(Alignment.CenterHorizontally),
            colors = ButtonDefaults.buttonColors(containerColor = buttonColor),
            shape = RoundedCornerShape(20.dp),
            elevation = ButtonDefaults.buttonElevation(defaultElevation = 0.dp)
        ) {
            Text(
                text = stringResource(id = R.string.submit_button),
                color = textColor,
                fontWeight = FontWeight.Black,
                fontSize = 20.sp
            )
        }

        Spacer(modifier = Modifier.height(12.dp))

        Button(
            onClick = onCancelClick,
            modifier = Modifier
                .fillMaxWidth(0.65f)
                .height(56.dp)
                .align(Alignment.CenterHorizontally),
            colors = ButtonDefaults.buttonColors(containerColor = secondaryButtonColor),
            shape = RoundedCornerShape(20.dp),
            elevation = ButtonDefaults.buttonElevation(defaultElevation = 0.dp)
        ) {
            Text(
                text = stringResource(id = R.string.cancel_button),
                color = subtitleColor,
                fontWeight = FontWeight.Bold,
                fontSize = 20.sp
            )
        }
        
        Spacer(modifier = Modifier.height(32.dp))
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
            fontSize = 15.sp,
            fontWeight = FontWeight.Bold,
            color = textColor,
            modifier = Modifier.padding(bottom = 6.dp)
        )
        TextField(
            value = value,
            onValueChange = onValueChange,
            modifier = Modifier
                .fillMaxWidth()
                .height(56.dp),
            shape = RoundedCornerShape(16.dp),
            colors = TextFieldDefaults.colors(
                focusedContainerColor = backgroundColor,
                unfocusedContainerColor = backgroundColor,
                disabledContainerColor = backgroundColor,
                focusedIndicatorColor = Color.Transparent,
                unfocusedIndicatorColor = Color.Transparent,
                disabledIndicatorColor = Color.Transparent,
                cursorColor = Color.Black
            ),
            singleLine = true
        )
    }
}

@Composable
fun PasswordRequirements(
    textColor: Color,
    modifier: Modifier = Modifier
) {
    Column(modifier = modifier.fillMaxWidth(), verticalArrangement = Arrangement.spacedBy(2.dp)) {
        val fontSize = 16.sp
        Text(
            text = stringResource(id = R.string.password_requirement_length),
            fontSize = fontSize,
            color = textColor
        )
        Text(
            text = stringResource(id = R.string.password_requirement_uppercase),
            fontSize = fontSize,
            color = textColor
        )
        Text(
            text = stringResource(id = R.string.password_requirement_lowercase),
            fontSize = fontSize,
            color = textColor
        )
        Text(
            text = stringResource(id = R.string.password_requirement_special),
            fontSize = fontSize,
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
