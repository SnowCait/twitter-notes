public class Timeline
{
    // タイムラインの情報
    public string Title { get; set; }

    // タイムラインアイテム
    public int NewestId { get; set; }
    public int OldestId { get; set; }

    public async void LoadNewerAsync();
    public async void LoadOlderAsync();
}

public interface ITimelineItem
{
    int Id { get; set; }
}

public class TwitterTimelineItem
{
    public int Id { get; set; }
    public string Json { get; set; }
}
