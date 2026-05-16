package com.example.fitlog.ui

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.SpanStyle
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.input.VisualTransformation
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.fitlog.R

@Composable
fun CreateProfileScreen(
    modifier: Modifier = Modifier,
    onInitializeClick: () -> Unit = {}
) {
    val backgroundColor = Color.Black
    val accentColor = Color(0xFFD0FD3E)
    val fieldBackgroundColor = Color(0xFF1C1C1E)
    val labelTextColor = Color(0xFF8E8E93)

    var athleteHandle by remember { mutableStateOf("") }
    var emailProtocol by remember { mutableStateOf("") }
    var commsLink by remember { mutableStateOf("") }
    var accessKey by remember { mutableStateOf("") }
    var verifyKey by remember { mutableStateOf("") }
    var athleticObjective by remember { mutableStateOf("") }
    var termsAccepted by remember { mutableStateOf(false) }

    Scaffold(
        modifier = modifier.fillMaxSize(),
        containerColor = backgroundColor
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
                verticalAlignment = Alignment.CenterVertically
            ) {
                Icon(
                    painter = painterResource(id = R.drawable.ic_back_arrow),
                    contentDescription = stringResource(R.string.back_button_content_description),
                    tint = Color.White,
                    modifier = Modifier
                        .size(24.dp)
                        .clickable { /* Handle back */ }
                )
                Text(
                    text = stringResource(R.string.fitlog_logo),
                    color = Color.White,
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Black,
                    letterSpacing = 2.sp
                )
                Spacer(modifier = Modifier.width(24.dp))
            }

            Spacer(modifier = Modifier.height(32.dp))

            Text(
                text = buildAnnotatedString {
                    append(stringResource(R.string.create_profile_title))
                    append("\n")
                    withStyle(style = SpanStyle(color = accentColor)) {
                        append(stringResource(R.string.profile_title_accent))
                    }
                },
                color = Color.White,
                fontSize = 32.sp,
                fontWeight = FontWeight.Black,
                lineHeight = 36.sp
            )

            Spacer(modifier = Modifier.height(8.dp))

            Text(
                text = stringResource(R.string.create_profile_subtitle),
                color = labelTextColor,
                fontSize = 14.sp,
                fontWeight = FontWeight.Medium
            )

            Spacer(modifier = Modifier.height(32.dp))

            Box(
                modifier = Modifier
                    .size(120.dp)
                    .align(Alignment.CenterHorizontally)
            ) {
                Box(
                    modifier = Modifier
                        .fillMaxSize()
                        .clip(CircleShape)
                        .background(Color(0xFF1C1C1E))
                        .border(1.dp, Color(0xFF333333), CircleShape)
                )
                
                Box(
                    modifier = Modifier
                        .align(Alignment.BottomEnd)
                        .size(36.dp)
                        .clip(CircleShape)
                        .background(accentColor)
                        .clickable { /* Handle photo */ },
                    contentAlignment = Alignment.Center
                ) {
                    Icon(
                        painter = painterResource(id = R.drawable.ic_camera),
                        contentDescription = stringResource(R.string.camera_icon_description),
                        tint = Color.Black,
                        modifier = Modifier.size(20.dp)
                    )
                }
            }

            Spacer(modifier = Modifier.height(40.dp))

            ProfileInputField(
                label = stringResource(R.string.athlete_handle_label),
                value = athleteHandle,
                onValueChange = { athleteHandle = it },
                hint = stringResource(R.string.athlete_handle_hint),
                backgroundColor = fieldBackgroundColor,
                labelColor = labelTextColor
            )

            Spacer(modifier = Modifier.height(20.dp))

            ProfileInputField(
                label = stringResource(R.string.email_protocol_label),
                value = emailProtocol,
                onValueChange = { emailProtocol = it },
                hint = stringResource(R.string.email_protocol_hint),
                backgroundColor = fieldBackgroundColor,
                labelColor = labelTextColor,
                keyboardType = KeyboardType.Email
            )

            Spacer(modifier = Modifier.height(20.dp))

            ProfileInputField(
                label = stringResource(R.string.comms_link_label),
                value = commsLink,
                onValueChange = { commsLink = it },
                hint = stringResource(R.string.comms_link_hint),
                backgroundColor = fieldBackgroundColor,
                labelColor = labelTextColor,
                keyboardType = KeyboardType.Phone
            )

            Spacer(modifier = Modifier.height(20.dp))

            ProfileInputField(
                label = stringResource(R.string.access_key_label),
                value = accessKey,
                onValueChange = { accessKey = it },
                hint = "********",
                backgroundColor = fieldBackgroundColor,
                labelColor = labelTextColor,
                isPassword = true
            )

            Spacer(modifier = Modifier.height(20.dp))

            ProfileInputField(
                label = stringResource(R.string.verify_key_label),
                value = verifyKey,
                onValueChange = { verifyKey = it },
                hint = "********",
                backgroundColor = fieldBackgroundColor,
                labelColor = labelTextColor,
                isPassword = true
            )

            Spacer(modifier = Modifier.height(20.dp))

            ProfileInputField(
                label = stringResource(R.string.athletic_objective_label),
                value = athleticObjective,
                onValueChange = { athleticObjective = it },
                hint = stringResource(R.string.athletic_objective_hint),
                backgroundColor = fieldBackgroundColor,
                labelColor = labelTextColor,
                singleLine = false,
                minHeight = 100.dp
            )

            Spacer(modifier = Modifier.height(24.dp))

            Row(
                verticalAlignment = Alignment.CenterVertically,
                modifier = Modifier
                    .padding(bottom = 32.dp)
                    .clickable { termsAccepted = !termsAccepted }
            ) {
                Box(
                    modifier = Modifier
                        .size(20.dp)
                        .border(
                            width = 1.dp,
                            color = if (termsAccepted) accentColor else Color(0xFF3A3A3C),
                            shape = RoundedCornerShape(4.dp)
                        )
                        .background(
                            color = if (termsAccepted) accentColor else Color.Transparent,
                            shape = RoundedCornerShape(4.dp)
                        ),
                    contentAlignment = Alignment.Center
                ) {
                    if (termsAccepted) {
                        Icon(
                            painter = painterResource(id = R.drawable.ic_chevron_right),
                            contentDescription = null,
                            tint = Color.Black,
                            modifier = Modifier.size(14.dp)
                        )
                    }
                }
                Spacer(modifier = Modifier.width(12.dp))
                Text(
                    text = buildAnnotatedString {
                        append(stringResource(R.string.accept_terms_prefix))
                        append(" ")
                        withStyle(style = SpanStyle(color = accentColor, fontWeight = FontWeight.Bold)) {
                            append(stringResource(R.string.terms_and_conditions))
                        }
                    },
                    color = Color.White,
                    fontSize = 14.sp
                )
            }

            Button(
                onClick = onInitializeClick,
                modifier = Modifier
                    .fillMaxWidth()
                    .height(64.dp),
                shape = RoundedCornerShape(16.dp),
                colors = ButtonDefaults.buttonColors(containerColor = accentColor)
            ) {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.Center,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = stringResource(R.string.initialize_performance),
                        color = Color.Black,
                        fontSize = 16.sp,
                        fontWeight = FontWeight.Black
                    )
                    Spacer(modifier = Modifier.width(8.dp))
                    Icon(
                        painter = painterResource(id = R.drawable.ic_arrow_forward),
                        contentDescription = null,
                        tint = Color.Black,
                        modifier = Modifier.size(20.dp)
                    )
                }
            }

            Spacer(modifier = Modifier.height(24.dp))

            Text(
                text = stringResource(R.string.step_count),
                color = Color(0xFF48484A),
                fontSize = 10.sp,
                fontWeight = FontWeight.Bold,
                modifier = Modifier.fillMaxWidth(),
                textAlign = TextAlign.Center,
                letterSpacing = 2.sp
            )

            Spacer(modifier = Modifier.height(24.dp))
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ProfileInputField(
    label: String,
    value: String,
    onValueChange: (String) -> Unit,
    hint: String,
    backgroundColor: Color,
    labelColor: Color,
    isPassword: Boolean = false,
    keyboardType: KeyboardType = KeyboardType.Text,
    singleLine: Boolean = true,
    minHeight: Dp = 56.dp
) {
    Column(modifier = Modifier.fillMaxWidth()) {
        Text(
            text = label,
            color = labelColor,
            fontSize = 10.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.padding(bottom = 8.dp)
        )
        TextField(
            value = value,
            onValueChange = onValueChange,
            modifier = Modifier
                .fillMaxWidth()
                .defaultMinSize(minHeight = minHeight)
                .clip(RoundedCornerShape(12.dp)),
            placeholder = {
                Text(
                    text = hint,
                    color = Color(0xFF3A3A3C),
                    fontSize = 14.sp
                )
            },
            visualTransformation = if (isPassword) PasswordVisualTransformation() else VisualTransformation.None,
            keyboardOptions = KeyboardOptions(
                keyboardType = keyboardType,
                imeAction = ImeAction.Next
            ),
            singleLine = singleLine,
            colors = TextFieldDefaults.colors(
                focusedContainerColor = backgroundColor,
                unfocusedContainerColor = backgroundColor,
                disabledContainerColor = backgroundColor,
                cursorColor = Color(0xFFD0FD3E),
                focusedIndicatorColor = Color.Transparent,
                unfocusedIndicatorColor = Color.Transparent,
                disabledIndicatorColor = Color.Transparent,
                focusedTextColor = Color.White,
                unfocusedTextColor = Color.White
            ),
            textStyle = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Medium)
        )
    }
}

@Preview(showBackground = true, backgroundColor = 0xFF000000)
@Composable
fun CreateProfileScreenPreview() {
    MaterialTheme {
        CreateProfileScreen()
    }
}
