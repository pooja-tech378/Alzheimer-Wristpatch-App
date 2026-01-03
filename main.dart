import 'package:wrist_patch_app_fixed/medication_dashboard.dart';
import 'language_selection_screen.dart';
import 'meal_reminder_screen.dart';
import 'package:flutter/material.dart';
import 'walking_schedule_screen.dart';
import 'patient_Map_screen.dart';
import 'caregiver_voice_command.dart';
import 'patient_alerts_screen.dart';
import 'voice_assistant_grid.dart';
import 'moodassistant.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const SplashScreen(),
    );
  }
}

// ------------------- Splash Screen -------------------
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/alzheimer_logo.jpg", width: 150),
            const SizedBox(height: 20),
            const Text(
              "Alzheimer Assistant",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent,
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(color: Colors.purpleAccent),
          ],
        ),
      ),
    );
  }
}

// ------------------- Role Selection -------------------
class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});
  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? selectedRole;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Select Role")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Choose your role:",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),
            RadioListTile<String>(
              title: const Text(
                "Patient",
                style: TextStyle(color: Colors.white),
              ),
              value: "Patient",
              groupValue: selectedRole,
              onChanged: (v) => setState(() => selectedRole = v),
            ),
            RadioListTile<String>(
              title: const Text(
                "Caregiver",
                style: TextStyle(color: Colors.white),
              ),
              value: "Caregiver",
              groupValue: selectedRole,
              onChanged: (v) => setState(() => selectedRole = v),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
              ),
              onPressed: () {
                if (selectedRole != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginPage(role: selectedRole!),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a role")),
                  );
                }
              },
              child: const Text(
                "Continue",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- Login Page -------------------
class LoginPage extends StatelessWidget {
  final String role;
  const LoginPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("$role Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.white70),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.white70),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
              ),
              onPressed: () {
                if (role == "Patient") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LanguageSelectionScreen(),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CaregiverDashboard(),
                    ),
                  );
                }
              },
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- Patient Dashboard -------------------
// ------------------- Patient Dashboard -------------------

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Patient Dashboard")),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Patient Overview",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // ALL features in GridView
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    dashboardCard(
                      "Voice Assistant",
                      "Talk in any language",
                      Icons.mic,
                      Colors.orangeAccent,
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VoiceAssistantGrid(),
                          ),
                        );
                      },
                    ),
                    dashboardCard(
                      "Heart Rate",
                      "72 bpm",
                      Icons.favorite,
                      Colors.redAccent,
                    ),
                    dashboardCard(
                      "Blood Pressure",
                      "120/80",
                      Icons.monitor_heart,
                      Colors.blueAccent,
                    ),
                    dashboardCard(
                      "Steps",
                      "2500",
                      Icons.directions_walk,
                      Colors.greenAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WalkingScheduleScreen(),
                          ),
                        );
                      },
                    ),
                    dashboardCard(
                      "Sleep",
                      "7 hrs",
                      Icons.bedtime,
                      Colors.orangeAccent,
                    ),
                    dashboardCard(
                      "Mood Analyser",
                      "Happy",
                      Icons.mood,
                      Colors.purpleAccent,

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => MoodAssistant()),
                        );
                      },
                    ),

                    dashboardCard(
                      "Medication",
                      "View Dashboard",
                      Icons.medical_services,
                      Colors.tealAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MedicationDashboard(),
                          ),
                        );
                      },
                    ),
                    dashboardCard(
                      "Meal Reminder",
                      "Set food reminders",
                      Icons.restaurant_menu,
                      Colors.orangeAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MealReminderScreen(),
                          ),
                        );
                      },
                    ),
                    dashboardCard(
                      "Current Location",
                      "GPS tracking",
                      Icons.location_on,
                      Colors.redAccent,
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => PatientMapScreen()),
                        );
                      },
                    ),
                    dashboardCard(
                      "Alerts",
                      "No new alerts",
                      Icons.notification_important,
                      Colors.purpleAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PatientAlertsScreen(),
                          ),
                        );
                        // TODO: integrate notifications
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------- Caregiver Dashboard -------------------
class CaregiverDashboard extends StatelessWidget {
  const CaregiverDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Caregiver Dashboard")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Caregiver Overview",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  dashboardCard(
                    "Patient Location",
                    "Lat:12.97, Long:77.59",
                    Icons.location_on,
                    Colors.redAccent,
                    onTap: () {
                      // TODO: show live patient location
                    },
                  ),
                  dashboardCard(
                    "Voice Commands",
                    "Tap to send commands",
                    Icons.mic,
                    Colors.orangeAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CaregiverVoiceCommandScreen(),
                        ),
                      );
                      // TODO: integrate caregiver voice assistant
                    },
                  ),
                  dashboardCard(
                    "Alerts",
                    " new alerts",
                    Icons.notification_important,
                    Colors.purpleAccent,
                    onTap: () {
                      // TODO: integrate alert notifications
                    },
                  ),
                  dashboardCard(
                    "Tasks",
                    "Check medications",
                    Icons.list,
                    Colors.greenAccent,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------- Helper Card -------------------
Widget dashboardCard(
  String title,
  String subtitle,
  IconData icon,
  Color color, {
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 36),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
