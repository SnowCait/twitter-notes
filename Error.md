# Error

## `/oauth/request_token`
```json
{"errors":[{"code":32,"message":"Could not authenticate you."}]}
```
[知識がなくても解決できていたのか？ | Ken's blog @teaplanet](https://blog.teapla.net/2014/05/5115/)

## BOT として一時的にアカウントが停止

アカウントにログインして ReCapture と SMS 認証をして BOT でないことを証明すれば解除される。

```
CoreTweet.TwitterException
  HResult=0x80131500
  Message=To protect our users from spam and other malicious activity, this account is temporarily locked. Please log in to https://twitter.com to unlock your account.
  Source=CoreTweet
  スタック トレース:
   at CoreTweet.Core.InternalUtils.<>c.<<ResponseCallback>b__29_0>d.MoveNext()
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at CoreTweet.Core.InternalUtils.<ReadResponse>d__30`1.MoveNext()
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()
   at KindleScraping.Twitter.<Tweet>d__5.MoveNext() in C:\Users\SnowCait\Source\Repos\KindleScraping\KindleScraping\Twitter.cs:line 36
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()
   at KindleScraping.Program.<PrimeVideoNews>d__3.MoveNext() in C:\Users\SnowCait\Source\Repos\KindleScraping\KindleScraping\Program.cs:line 76
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at KindleScraping.Program.<>c.<<Main>b__2_0>d.MoveNext() in C:\Users\SnowCait\Source\Repos\KindleScraping\KindleScraping\Program.cs:line 28

  この例外は、最初にこの呼び出し履歴でスローされました:
	CoreTweet.Core.InternalUtils.ResponseCallback.AnonymousMethod__29_0(CoreTweet.AsyncResponse)
	System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
	System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(System.Threading.Tasks.Task)
	System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(System.Threading.Tasks.Task)
	CoreTweet.Core.InternalUtils.ReadResponse<T>(System.Threading.Tasks.Task<CoreTweet.AsyncResponse>, System.Func<string, T>, System.Threading.CancellationToken)
	System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
	System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(System.Threading.Tasks.Task)
	System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(System.Threading.Tasks.Task)
	System.Runtime.CompilerServices.ConfiguredTaskAwaitable<TResult>.ConfiguredTaskAwaiter.GetResult()
    KindleScraping.Twitter.Tweet(string, System.Uri) の Twitter.cs
    ...
    [呼び出し履歴の切り捨て]
```

## Over capacity

```
CoreTweet.TwitterException
  HResult=0x80131500
  Message=Over capacity
  Source=CoreTweet
  スタック トレース:
   at CoreTweet.Core.InternalUtils.<>c.<<ResponseCallback>b__29_0>d.MoveNext()
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at CoreTweet.Core.InternalUtils.<ReadResponse>d__30`1.MoveNext()
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()
   at KindleScraping.Twitter.<Tweet>d__5.MoveNext() in C:\Users\SnowCait\Source\Repos\KindleScraping\KindleScraping\Twitter.cs:line 36
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()
   at KindleScraping.Program.<PrimeVideoNews>d__3.MoveNext() in C:\Users\SnowCait\Source\Repos\KindleScraping\KindleScraping\Program.cs:line 76
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at KindleScraping.Program.<>c.<<Main>b__2_0>d.MoveNext() in C:\Users\SnowCait\Source\Repos\KindleScraping\KindleScraping\Program.cs:line 28

  この例外は、最初にこの呼び出し履歴でスローされました:
	CoreTweet.Core.InternalUtils.ResponseCallback.AnonymousMethod__29_0(CoreTweet.AsyncResponse)
	System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
	System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(System.Threading.Tasks.Task)
	System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(System.Threading.Tasks.Task)
	CoreTweet.Core.InternalUtils.ReadResponse<T>(System.Threading.Tasks.Task<CoreTweet.AsyncResponse>, System.Func<string, T>, System.Threading.CancellationToken)
	System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
	System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(System.Threading.Tasks.Task)
	System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(System.Threading.Tasks.Task)
	System.Runtime.CompilerServices.ConfiguredTaskAwaitable<TResult>.ConfiguredTaskAwaiter.GetResult()
    KindleScraping.Twitter.Tweet(string, System.Uri) の Twitter.cs
    ...
    [呼び出し履歴の切り捨て]
```
