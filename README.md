# Flutter Chat Module with Firebase Integration

This Flutter chat module is designed as a versatile plugin that can be seamlessly integrated into any Flutter app requiring chat functionality. By including this package and following a few configuration steps, you can easily enable chat features within your application.

## Description

This chat module is built using Firebase and offers a comprehensive set of features for real-time messaging. It's intended to be a plug-and-play solution, allowing you to incorporate chat capabilities into your app without extensive development efforts.

## Steps to Integrate

Follow these steps to integrate the chat module into your Flutter app:

1. **Download and Include Package**: Download the chat module package and include it in the root folder of your app.

2. **Update pubspec.yaml**: In your `pubspec.yaml` file, add the following lines to include the chat module and the required provider package:

    ```yaml
    dependencies:
      kb_chat_module:
        git:
          url: https://github.com/mahi2swt/my-chat.git
    ```

3. **Connect Firebase Services**: Configure your Firebase project to support the chat module by enabling the following Firebase services:
    1. **Authentication**: Enable Google authentication for user sign-in.
    2. **Realtime Database**: Utilize the Realtime Database to manage user details and messages.
    3. **Storage**: Store images and multimedia files.
    4. **Cloud Messaging**: Set up Cloud Messaging for push notifications.

4. **Set Up Local Notifications**: Implement local notifications within your app to enable push notification functionality.

5. **Import Chat Screen**: In the desired location of your app, import the chat screen using the following code:

    ```dart
    import 'package:kb_chat_module/kb_chat.dart';
    ```

6. **Initialize Chat Module**: Add the following code to initialize the chat module:

    ```dart
    return KbChatModule(
      firebaseAuthUser: FirebaseAuth Auth user model,
      pushNotificationKey: 'NOTIFICATION_KEY_PROVIDED_BY_GOOGLE_CONSOLE',
      notificationChannelName: 'YOUR_CHANNEL_NAME_MENTIONED_FOR_PUSH_NOTIFICATION',
    );
    ```

7. **Customize Appearance (Optional)**: You can customize the chat module's appearance by providing optional parameters:
    - **theme**: Set the overall theme for the chat module. If not provided, the default material theme will be used.
    - **recivesMsgBoxDesign**: Customize the appearance of received message boxes using the `MessageBox` class. You can adjust text style, date-time style, padding, and more.
    - **sendMsgBoxDesign**: Customize the appearance of sent message boxes using the `MessageBox` class, just like with received messages.

    Example:

    ```dart
    return KbChatModule(
      firebaseAuthUser: FirebaseAuth Auth user model,
      pushNotificationKey: 'NOTIFICATION_KEY_PROVIDED_BY_GOOGLE_CONSOLE',
      notificationChannelName: 'YOUR_CHANNEL_NAME_MENTIONED_FOR_PUSH_NOTIFICATION',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      recivesMsgBoxDesign: MessageBox(
        messageBoxStyle: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontSize: 12,
        ),
        dateTimeTextStyle: const TextStyle(
          fontSize: 8,
        ),
        innerPadding: const EdgeInsets.all(10),
        outerPadding: const EdgeInsets.all(10),
      ),
      sendMsgBoxDesign: MessageBox(
        messageBoxStyle: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontSize: 12,
        ),
        dateTimeTextStyle: const TextStyle(
          fontSize: 8,
        ),
        innerPadding: const EdgeInsets.all(10),
        outerPadding: const EdgeInsets.all(10),
      ),
    );
    ```

By following these steps and customizing the module to your requirements, you can seamlessly integrate a comprehensive chat functionality into your Flutter app using Firebase.
