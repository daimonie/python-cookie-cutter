from main import func


def test_func():
    result = func()

    assert isinstance(result, str), "Func did not return a str."
    assert len(result) > 10, "Insufficient length on func from main."
