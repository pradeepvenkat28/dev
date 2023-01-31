trigger FeedCommentTrigger on FeedComment (after insert, after update) {

  account a = new account(name = 'feedcomment');
  insert a;

}