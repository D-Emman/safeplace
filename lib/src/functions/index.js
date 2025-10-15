const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

// Scheduler: create message of the day at 00:00 UTC (adjust to desired timezone)
exports.generateDailyContent = functions.pubsub.schedule('0 0 * * *').timeZone('UTC').onRun(async (context) => {
  const today = new Date();
  const yyyy = today.getUTCFullYear();
  const mm = String(today.getUTCMonth() + 1).padStart(2, '0');
  const dd = String(today.getUTCDate()).padStart(2, '0');
  const id = `${yyyy}-${mm}-${dd}`;

  // Simple sample content - replace with richer generator / CMS
  const messages = [
    "Small steps are progress.",
    "You are allowed to take time.",
    "Breathe. One moment at a time."
  ];
  const advices = [
    "Try a 2-minute grounding technique.",
    "Take 5 slow, deep breaths when anxious.",
    "If you can, step outside and feel sunlight for a minute."
  ];
  const message = messages[Math.floor(Math.random() * messages.length)];
  const advice = advices[Math.floor(Math.random() * advices.length)];

  await db.collection('daily_content').doc(id).set({
    date: admin.firestore.Timestamp.fromDate(today),
    message,
    advice,
    createdAt: admin.firestore.FieldValue.serverTimestamp()
  });

  console.log(`Created daily content for ${id}`);
  return null;
});

// Trigger: when a post or comment is flagged (isReported = true), copy into moderation queue
exports.onReportCreated = functions.firestore.document('{collectionId}/{docId}')
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();
    if (!after) return;
    // Only act when isReported flips from false to true
    if (before && before.isReported === true) return null;
    if (after.isReported === true) {
      const collection = context.params.collectionId;
      const docId = context.params.docId;
      const payload = {
        collection,
        docId,
        reportedAt: admin.firestore.FieldValue.serverTimestamp(),
        reportReason: after.reportReason || '',
        content: after.content || '',
        username: after.username || '',
        reviewed: false
      };
      await db.collection('moderation_queue').add(payload);
      console.log(`Queued ${collection}/${docId} for moderation`);
    }
    return null;
});
