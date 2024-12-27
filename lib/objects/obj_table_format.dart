import 'package:flutter/material.dart';

class ObjTableFormat {
  final int textSize;
  final int buttonTextSize;
  final int paddingLeft;
  final int paddingRight;
  final int paddingTop;
  final int paddingBottom;
  final Color textColor;
  final Color textColorHighlight;
  final Color textColorDim;
  final Color buttonColor;
  final Color lineColor;
  final Color backgroundColor;
  final Color altBackgroundColor;

  ObjTableFormat(String format)
      : textSize = 16,
        buttonTextSize = 20,
        paddingLeft = 6,
        paddingRight = 6,
        paddingTop = 6,
        paddingBottom = 6,
        textColor = _getTextColor(format),
        textColorHighlight = _getTextColorHighlight(format),
        textColorDim = _getTextColorDim(format),
        buttonColor = _getButtonColor(format),
        lineColor = _getLineColor(format),
        backgroundColor = _getBackgroundColor(format),
        altBackgroundColor = _getAltBackgroundColor(format);

  static Color _getTextColor(String format) {
    switch (format) {
      case "fmtDeal":
        return const Color(0xFFE53935); // Red
      case "fmtGift":
        return const Color(0xFFFFC107); // Yellow
      case "fmtMoney":
        return const Color(0xFF2196F3); // Blue
      case "fmtCharity":
      case "fmtZibit":
      default:
        return const Color(0xFF4CAF50); // Green
    }
  }

  static Color _getTextColorHighlight(String format) {
    switch (format) {
      case "fmtDeal":
        return const Color(0xFFD32F2F); // Dark Red
      case "fmtGift":
        return const Color(0xFFFFA000); // Amber
      case "fmtMoney":
        return const Color(0xFF1976D2); // Dark Blue
      case "fmtCharity":
      case "fmtZibit":
      default:
        return const Color(0xFF388E3C); // Dark Green
    }
  }

  static Color _getTextColorDim(String format) {
    switch (format) {
      case "fmtDeal":
        return const Color(0xFFFF8A80); // Light Red
      case "fmtGift":
        return const Color(0xFFFFECB3); // Light Yellow
      case "fmtMoney":
        return const Color(0xFF90CAF9); // Light Blue
      case "fmtCharity":
      case "fmtZibit":
      default:
        return const Color(0xFFC8E6C9); // Light Green
    }
  }

  static Color _getButtonColor(String format) {
    return _getTextColorHighlight(format);
  }

  static Color _getLineColor(String format) {
    return _getTextColorHighlight(format);
  }

  static Color _getBackgroundColor(String format) {
    switch (format) {
      case "fmtDeal":
        return const Color(0xFFFFCDD2); // Very Light Red
      case "fmtGift":
        return const Color(0xFFFFF9C4); // Very Light Yellow
      case "fmtMoney":
        return const Color(0xFFE3F2FD); // Very Light Blue
      case "fmtCharity":
      case "fmtZibit":
      default:
        return const Color(0xFFE8F5E9); // Very Light Green
    }
  }

  static Color _getAltBackgroundColor(String format) {
    switch (format) {
      case "fmtDeal":
        return const Color(0xFFFFEBEE); // Extra Light Red
      case "fmtGift":
        return const Color(0xFFFFFDE7); // Extra Light Yellow
      case "fmtMoney":
        return const Color(0xFFE3F2FD); // Extra Light Blue
      case "fmtCharity":
      case "fmtZibit":
      default:
        return const Color(0xFFF1F8E9); // Extra Light Green
    }
  }
}
