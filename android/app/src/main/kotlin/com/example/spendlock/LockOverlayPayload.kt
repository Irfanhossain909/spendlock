package com.example.spendlock

import org.json.JSONObject

data class LockOverlayPayload(
    val ruleMessage: String,
    val isLimitBased: Boolean,
    val remainingSeconds: Int,
) {
    fun toJson(): JSONObject {
        return JSONObject().apply {
            put("ruleMessage", ruleMessage)
            put("isLimitBased", isLimitBased)
            put("remainingSeconds", remainingSeconds)
        }
    }

    companion object {
        fun default(packageName: String): LockOverlayPayload {
            return LockOverlayPayload(
                ruleMessage = "This app is blocked by SpendLock",
                isLimitBased = false,
                remainingSeconds = 0,
            )
        }

        fun fromJson(json: JSONObject): LockOverlayPayload {
            return LockOverlayPayload(
                ruleMessage = json.optString("ruleMessage", "Your rule is currently active"),
                isLimitBased = json.optBoolean("isLimitBased", false),
                remainingSeconds = json.optInt("remainingSeconds", 0),
            )
        }

        fun fromMap(map: Map<*, *>?): LockOverlayPayload? {
            if (map == null) return null
            return LockOverlayPayload(
                ruleMessage = map["ruleMessage"]?.toString()
                    ?: "Your rule is currently active",
                isLimitBased = map["isLimitBased"] as? Boolean ?: false,
                remainingSeconds = (map["remainingSeconds"] as? Number)?.toInt() ?: 0,
            )
        }
    }
}
