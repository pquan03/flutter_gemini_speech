import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:winter_gemini_ai/config/constants/app_color.dart';
import 'package:winter_gemini_ai/config/constants/app_images.dart';
import 'package:winter_gemini_ai/model/message.dart';
import 'package:winter_gemini_ai/pages/chat/widgets/message_item.dart';
import 'package:winter_gemini_ai/pages/chat/widgets/typing_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FlutterTts _flutterTts = FlutterTts();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  void callGeminiModel() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(Message(text: _controller.text, isUser: true));
        _isLoading = true;
      });
      _controller.clear();
      _animateToBottom();
    } else {
      return;
    }
    try {
      final model = GenerativeModel(
          model: 'gemini-1.5-flash-latest',
          apiKey: dotenv.env['GOOGLE_API_KEY']!);
      final prompt = _messages.last.text;
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      speak(response.text!);
      setState(() {
        _messages.add(Message(text: response.text!, isUser: false));
        _isLoading = false;
      });
      _animateToBottom();
    } catch (e) {
      print("Error : $e");
    }
  }

  void _initTTS() async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setPitch(1);
    await _flutterTts.setSpeechRate(0.5);
  }

  void speak(String text) async {
    _initTTS();
    await _flutterTts.speak(text);
  }

  void _animateToBottom() {
    if (_messages.length > 5) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 64,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                speak('');
              },
              icon: Image.asset(AppImages.volumeHigh))
        ],
        title: Row(
          children: [
            Image.asset(
              AppImages.gptRobot,
              height: 26,
              width: 24,
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Chat GPT',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary),
                ),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      'Online',
                      style: TextStyle(fontSize: 17, color: Colors.green),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 64),
            child: ListView.builder(
                controller: _scrollController,
                itemCount: _isLoading ? _messages.length + 1 : _messages.length,
                itemBuilder: (context, index) {
                  if (_isLoading && index == _messages.length) {
                    return const TypingMessage();
                  }
                  final message = _messages[index];
                  return MessaegItem(message: message);
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 56,
              margin: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3))
                  ]),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: InputDecoration(
                          hintText: 'Write your message',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20)),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: callGeminiModel,
                      child: Image.asset(AppImages.send),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
