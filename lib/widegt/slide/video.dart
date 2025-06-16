import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerComponent extends StatefulWidget {
  final VideoPlayerController videoController;
  final bool autoPlay;
  final bool looping;
  final Function(bool)? onFullScreenChange;

  const VideoPlayerComponent({
    Key? key,
    required this.videoController,
    this.autoPlay = false,
    this.looping = false,
    this.onFullScreenChange,
  }) : super(key: key);

  @override
  State<VideoPlayerComponent> createState() => _VideoPlayerComponentState();
}

class _VideoPlayerComponentState extends State<VideoPlayerComponent> {
  late ChewieController _chewieController;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeChewieController();
  }

  void _initializeChewieController() {
    // 直接使用外部传入的videoController
    _chewieController = ChewieController(
      videoPlayerController: widget.videoController,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
      showControls: true,
      allowFullScreen: true,
      allowMuting: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
      // 添加全屏状态变化回调
      // onFullScreenChange: widget.onFullScreenChange,
    );

    // 如果外部controller已经初始化，直接更新状态
    if (widget.videoController.value.isInitialized) {
      setState(() => _isControllerInitialized = true);
    } else {
      // 监听外部controller的初始化状态
      widget.videoController.addListener(_checkVideoInitStatus);
    }
  }

  void _checkVideoInitStatus() {
    if (widget.videoController.value.isInitialized && !_isControllerInitialized) {
      setState(() => _isControllerInitialized = true);
    }
  }

  @override
  void didUpdateWidget(VideoPlayerComponent oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 如果外部controller发生变化，重新初始化Chewie
    if (oldWidget.videoController != widget.videoController) {
      _chewieController.dispose();
      _initializeChewieController();
    }
  }

  @override
  void dispose() {
    widget.videoController.removeListener(_checkVideoInitStatus);
    _chewieController.dispose();
    // 注意：不再dispose外部传入的videoController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isControllerInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return AspectRatio(
      aspectRatio: widget.videoController.value.aspectRatio,
      child: Chewie(controller: _chewieController),
    );
  }
}