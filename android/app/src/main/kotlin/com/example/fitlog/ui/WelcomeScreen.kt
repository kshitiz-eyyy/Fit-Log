package com.example.fitlog.ui

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
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

private val DarkBackground = Color(0xFF000000)
private val CardBorderColor = Color(0xFF7B61FF)
private val SecondaryLime = Color(0xFFC6FF00)
private val PrimaryOrange = Color(0xFFFF6D00)
private val TextGray = Color(0xFFBDBDBD)

@Composable
fun WelcomeScreen(
    modifier: Modifier = Modifier,
    onLoginClick: () -> Unit = {},
    onSignUpClick: () -> Unit = {}
) {
    Column(
        modifier = modifier
            .fillMaxSize()
            .background(DarkBackground)
            .padding(16.dp)
    ) {
        // Top Header
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 8.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Icon(
                painter = painterResource(id = R.drawable.ic_nav_dash),
                contentDescription = null,
                tint = Color.White,
                modifier = Modifier.size(24.dp)
            )
            Spacer(modifier = Modifier.width(8.dp))
            Text(
                text = stringResource(id = R.string.welcome_to_fitlog),
                color = Color.White,
                fontSize = 18.sp,
                fontWeight = FontWeight.Medium
            )
            Spacer(modifier = Modifier.weight(1f))
            Row(horizontalArrangement = Arrangement.spacedBy(16.dp)) {
                Icon(
                    painter = painterResource(id = R.drawable.ic_home),
                    contentDescription = null,
                    tint = Color.White,
                    modifier = Modifier.size(24.dp)
                )
                Icon(
                    painter = painterResource(id = R.drawable.ic_info),
                    contentDescription = null,
                    tint = Color.White,
                    modifier = Modifier.size(24.dp)
                )
                Icon(
                    painter = painterResource(id = R.drawable.ic_warning),
                    contentDescription = null,
                    tint = Color.White,
                    modifier = Modifier.size(24.dp)
                )
            }
        }

        Spacer(modifier = Modifier.height(8.dp))

        // Main Card
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .weight(1f)
                .border(BorderStroke(2.dp, CardBorderColor), RoundedCornerShape(24.dp))
                .clip(RoundedCornerShape(24.dp))
                .background(Color(0xFF0A0A0A))
        ) {
            // "Stitch - Design with AI" badge
            Surface(
                modifier = Modifier
                    .padding(16.dp)
                    .align(Alignment.TopStart),
                color = Color.White.copy(alpha = 0.1f),
                shape = RoundedCornerShape(4.dp),
                border = BorderStroke(1.dp, Color.White.copy(alpha = 0.2f))
            ) {
                Text(
                    text = stringResource(id = R.string.stitch_design_with_ai),
                    color = Color.White,
                    fontSize = 14.sp,
                    modifier = Modifier.padding(horizontal = 12.dp, vertical = 6.dp)
                )
            }

            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(24.dp),
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.Center
            ) {
                // Logo
                Row(
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Icon(
                        painter = painterResource(id = R.drawable.ic_bolt),
                        contentDescription = null,
                        tint = SecondaryLime,
                        modifier = Modifier.size(48.dp)
                    )
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(
                        text = "FITLOG",
                        color = SecondaryLime,
                        fontSize = 42.sp,
                        fontWeight = FontWeight.Black,
                        letterSpacing = (-1).sp
                    )
                }

                Spacer(modifier = Modifier.height(48.dp))

                // Headline
                Text(
                    text = stringResource(id = R.string.your_personal_fitness_companion),
                    color = Color.White,
                    fontSize = 28.sp,
                    fontWeight = FontWeight.ExtraBold,
                    textAlign = TextAlign.Center,
                    lineHeight = 34.sp
                )

                Spacer(modifier = Modifier.height(24.dp))

                // Description
                Text(
                    text = stringResource(id = R.string.welcome_description),
                    color = TextGray,
                    fontSize = 16.sp,
                    textAlign = TextAlign.Center,
                    lineHeight = 22.sp
                )

                Spacer(modifier = Modifier.height(64.dp))

                // Buttons
                Button(
                    onClick = onLoginClick,
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(56.dp),
                    colors = ButtonDefaults.buttonColors(containerColor = SecondaryLime),
                    shape = RoundedCornerShape(12.dp)
                ) {
                    Text(
                        text = stringResource(id = R.string.login_btn),
                        color = Color.Black,
                        fontSize = 16.sp,
                        fontWeight = FontWeight.Bold
                    )
                }

                Spacer(modifier = Modifier.height(16.dp))

                Button(
                    onClick = onSignUpClick,
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(56.dp),
                    colors = ButtonDefaults.buttonColors(containerColor = PrimaryOrange),
                    shape = RoundedCornerShape(12.dp)
                ) {
                    Text(
                        text = stringResource(id = R.string.signup_btn),
                        color = Color.White,
                        fontSize = 16.sp,
                        fontWeight = FontWeight.Bold
                    )
                }

                Spacer(modifier = Modifier.height(32.dp))

                // Pagination Indicator
                Row(
                    horizontalArrangement = Arrangement.spacedBy(8.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Box(modifier = Modifier.size(6.dp).background(SecondaryLime, CircleShape))
                    Box(modifier = Modifier.size(6.dp).background(PrimaryOrange, CircleShape))
                    Box(modifier = Modifier.size(6.dp).background(Color.DarkGray, CircleShape))
                }
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun WelcomeScreenPreview() {
    MaterialTheme {
        WelcomeScreen()
    }
}
